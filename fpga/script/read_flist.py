
import re
import os 

def repl_env(f_path):
    soc_dir = os.getenv('SOC_DIR')
    ip_dir  = os.getenv('IP_DIR')
    fpga_dir  = os.getenv('FPGA_DIR')
    top_dir  = os.getenv('TOP_DIR')
    top_dir  = os.getenv('TOP_DIR')


    open_cpu_type = os.getenv('OPEN_CPU_TYPE')
    code_base_path = os.getenv('CODE_BASE_PATH')

    #setenv  SOC_DIR "../../soc/"
    f_path  = f_path.replace('$SOC_DIR', soc_dir)
    f_path  = f_path.replace('${SOC_DIR}', soc_dir)    
    f_path  = f_path.replace('$IP_DIR',  ip_dir )
    f_path  = f_path.replace('${IP_DIR}',  ip_dir )
    f_path  = f_path.replace('$FPGA_DIR',  fpga_dir )
    f_path  = f_path.replace('${FPGA_DIR}',  fpga_dir )
    f_path  = f_path.replace('$TOP_DIR',  top_dir )
    f_path  = f_path.replace('${TOP_DIR}',  top_dir )
    f_path  = f_path.replace('$OPEN_CPU_TYPE',  open_cpu_type )
    f_path  = f_path.replace('${OPEN_CPU_TYPE}',  open_cpu_type )
    f_path  = f_path.replace('$CODE_BASE_PATH',  code_base_path )
    f_path  = f_path.replace('${CODE_BASE_PATH}',  code_base_path )


    f_path  = f_path.replace('\n','')
    f_path  = f_path.replace(' ','')
    return    f_path 
    

def get_incdir(flist_line):
    #search +incdir+ character ,return !0(if success),return 0(if fail)
    #(+incdir+$SOC_DIR/top/rtl/rtl_v/inc)
    is_incdir = re.search("incdir", flist_line)
    #not emy
    if (bool(is_incdir) == True):
        #delete +incdir+ characters ($SOC_DIR/top/rtl/rtl_v/inc)
        inc_path=flist_line.replace('+incdir+','')
        #path：../../soc/top/rtl/rtl_v/inc    ；  \“为转义字符双引号”
        #" ../../soc//top/rtl/rtl_v/inc "
        #path_str="\" "+repl_env(inc_path)+" \""
        # print(inc_path)
        #append inc_path " ../../soc//top/rtl/rtl_v/inc " ，字符串拼接，换行
        #return "append inc_path "+path_str+"\n"
        return  "add_files -fileset $obj -scan_for_includes [glob "+repl_env(inc_path)+"/*]\n"
    return ""

def get_f(flist_line):
    #-f $SOC_DIR/bus_subsys/rtl/flist/bus_subsys.f
    is_f = re.search("-f", flist_line)
    if (bool(is_f) == True):
        #delete -f characters ($SOC_DIR/bus_subsys/rtl/flist/bus_subsys.f)
        f_path=flist_line.replace('-f','')
        #path:../../soc/bus_subsys/rtl/flist/bus_subsys.f
        f_path=repl_env(f_path)
        return f_path
    return ""

def get_verilog(file_line):
    #在正则表达式中，. 表示匹配任意字符;如果要匹配字符串中的点号 .，可以使用 \. 进行转义
    is_verilog = re.search('\.v', file_line)
    is_sv = re.search('\.sv', file_line)
    is_h = re.search('\.h', file_line)
    is_vh= re.search('\.vh', file_line)

    # f_readfile.write(file_line)
    if (bool(is_h) | bool(is_vh) == True):
        verilog_file = "read_verilog -sv {"+repl_env(file_line)+"}\n"+"set_property is_global_include true [get_files "+repl_env(file_line)+"]\n"
        return verilog_file
        

    if (bool(is_verilog) | bool(is_sv) == True):
        #read_verilog -sv {../../soc//top/rtl/flist/define_m0.v}
        verilog_file = "read_verilog -sv {"+repl_env(file_line)+"}\n"
        # print(verilog_file)
        return verilog_file
    return ""

#read flist file
def read_flist(filelist,f_readfile):
    #open  flist file
    f_flist    =   open(filelist, "r+")
    
    #read file from flist
    flist_line = f_flist.readline()
             
    while flist_line :
        #add +incdir+ files 
        incdir_dat  = get_incdir(flist_line) 
        #../../soc/bus_subsys/rtl/flist/bus_subsys.f
        file_path   = get_f(flist_line)
        file_verilog= get_verilog(flist_line)
        #读到了//注释行
        is_comment  = re.search("\/\/", flist_line)
        if (bool(is_comment)):
            flist_line = f_flist.readline()
            #continue 是一个控制流语句，用于跳过当前循环中剩余的代码，直接进入下一次循环
            continue
        #读到了+incdir+文件目录行
        if (len(incdir_dat) != 0):
            #write incdir file to read_file.tcl 
            f_readfile.write(incdir_dat)
        #读到了.v文件行
        if (len(file_verilog) != 0):
            #write .v files to read_file.tcl
            f_readfile.write(file_verilog)

        #读到了cpu_subsystem.f文件(第一级.f,cpu_subsystem.f,read files from cpu_subsystem.f)
        if (len(file_path)  != 0):
            #../../soc/bus_subsys/rtl/flist/bus_subsys.f
            read_flist(file_path,f_readfile)
                                  
        flist_line = f_flist.readline()                             
    f_flist.close()

#get  top flist path
filelist=os.getenv('FLIST_PATH')

#for different cpu type
open_cpu_type = os.getenv('OPEN_CPU_TYPE')


#create a new file named read_file.tcl ,read .v .sv .vh files in this file
f_readfile =   open(f"../script/read_file_{open_cpu_type}.tcl", "w+")

#read file frome flist
read_flist(filelist,f_readfile)

f_readfile.close()


