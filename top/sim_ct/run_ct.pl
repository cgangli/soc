#!/usr/bin/perl 
use strict; 
use warnings;


						
#current dir:top/sim_ct/work
my $PWD = $ENV{'PWD'};
#sim_ct dir
my $sim_ct_dir = "${PWD}/..";
my $ip_dir = "${PWD}/../../../ip";

print("####current dir:$PWD\n");
print("####sim_ct dir:$sim_ct_dir\n");

#para
print "argv0:$ARGV[0]\n";
print "argv1:$ARGV[1]\n";
print "argv2:$ARGV[2]\n";
print "argv3:$ARGV[3]\n";

#upper2lower
my $argv2 = lc($ARGV[2]);


###########################################################################
# run sim
###########################################################################
#verdi or verdi_fpga
if($ARGV[0] eq "verdi_asic" || $ARGV[0] eq "verdi_fpga") {
    print("####run verdi or verdi_fpga\n");
    if(-e "${sim_ct_dir}/work/$ARGV[1]_$ARGV[2]_$ARGV[3]") {		
        chdir ("${sim_ct_dir}/work/$ARGV[1]_$ARGV[2]_$ARGV[3]");
        print "####make $ARGV[0] TEST_NAME=$ARGV[1] OPEN_CPU_TYPE=$ARGV[2] OPEN_CPU_MODE=$ARGV[3]";
        system ("make $ARGV[0] TEST_NAME=$ARGV[1] OPEN_CPU_TYPE=$ARGV[2] OPEN_CPU_MODE=$ARGV[3]");
    }
    else {
        die "case working dir does not exist";
    }

}
#asic or fpga
elsif($ARGV[0] eq "asic" || $ARGV[0] eq "fpga") {
    #save verdiLog dir for verdi reload
    if(-e "${sim_ct_dir}/work/$ARGV[1]_$ARGV[2]_$ARGV[3]/verdiLog") {
		system("cp -a ${sim_ct_dir}/work/$ARGV[1]_$ARGV[2]_$ARGV[3]/verdiLog ${sim_ct_dir}/work/verdiLog_$ARGV[1]");
	}

    #rm old case working dir
    if(-e "${sim_ct_dir}/work/$ARGV[1]_$ARGV[2]_$ARGV[3]") {
		system("rm -rf ${sim_ct_dir}/work/$ARGV[1]_$ARGV[2]_$ARGV[3]");
	}
    #create new case working dir
    system ("mkdir ${sim_ct_dir}/work/$ARGV[1]_$ARGV[2]_$ARGV[3]");
    
    #mv verdiLog
    if(-e "${sim_ct_dir}/work/verdiLog_$ARGV[1]") {
    system("mv ${sim_ct_dir}/work/verdiLog_$ARGV[1] ${sim_ct_dir}/work/$ARGV[1]_$ARGV[2]_$ARGV[3]/verdiLog");
    }
    
    #check C case 
    if ( -e "${sim_ct_dir}/tests/test_${argv2}/c_case/$ARGV[1]") {
        print("c case exist in:${sim_ct_dir}/tests/test_${argv2}/c_case/$ARGV[1]\n");
    }
    else {
        die "c case does not exist";
    }
    #######################################################################
    # E906
    #######################################################################
    if ($ARGV[2] eq "OPEN_E906"){
        #///////////////////////
        #core0
        #///////////////////////
        #ceate core0 dir
        system("mkdir ${sim_ct_dir}/work/$ARGV[1]_$ARGV[2]_$ARGV[3]/core0_$ARGV[1]_$ARGV[2]_$ARGV[3]"); 
        #e906 compile dir
        system("mkdir ${sim_ct_dir}/work/$ARGV[1]_$ARGV[2]_$ARGV[3]/core0_$ARGV[1]_$ARGV[2]_$ARGV[3]/work");    
        system("cp -rf ${ip_dir}/opene906-main/smart_run/tests  ${sim_ct_dir}/work/$ARGV[1]_$ARGV[2]_$ARGV[3]/core0_$ARGV[1]_$ARGV[2]_$ARGV[3]"); 
        #copy case and lib
        system("cp -rf ${sim_ct_dir}/tests/test_${argv2}/c_case/$ARGV[1]/core0_main.c ${sim_ct_dir}/work/$ARGV[1]_$ARGV[2]_$ARGV[3]/core0_$ARGV[1]_$ARGV[2]_$ARGV[3]/work "); 
        chdir("${sim_ct_dir}/work/$ARGV[1]_$ARGV[2]_$ARGV[3]/core0_$ARGV[1]_$ARGV[2]_$ARGV[3]");
        print("####Enter dir:${sim_ct_dir}/work/$ARGV[1]_$ARGV[2]_$ARGV[3]/core0_$ARGV[1]_$ARGV[2]_$ARGV[3]\n");         
        system("cp ./tests/lib/* ./work/"); #only copy file,no copy subdir
        system("cp ./tests/lib/clib/* ./work");
        system("cp ./tests/lib/newlib_wrap/* ./work");
        #run c case
        system("cd ./work && make -s clean && make -s all CPU_ARCH_FLAG_0=e906f CPU_ARCH_FLAG_1=nodsp  ENDIAN_MODE=little-endian CASENAME=core0_main FILE=$ARGV[1] >& $ARGV[1]_case.log");
        #check if case run succeed
        if(system("cp -rf ${sim_ct_dir}/work/$ARGV[1]_$ARGV[2]_$ARGV[3]/core0_$ARGV[1]_$ARGV[2]_$ARGV[3]/work/case.pat ${sim_ct_dir}/work/$ARGV[1]_$ARGV[2]_$ARGV[3]/core0.hex")) {die "####run c compile failed!"}

    }
    print "#######################################################################\n";
    print "run c compile finished!\n";
    print "#######################################################################\n";


    #######################################################################
    # copy scripts
    #######################################################################
    system("cp -a ${sim_ct_dir}/scripts/* ${sim_ct_dir}/work/$ARGV[1]_$ARGV[2]_$ARGV[3]");
    print "#######################################################################\n";
    print "copy scripts finished!\n";
    print "#######################################################################\n";



    #######################################################################
    # add case.sv
    #######################################################################
    if(-e "${sim_ct_dir}/tests/test_${argv2}/c_case/$ARGV[1]/case.sv"){
        system("cp -f ${sim_ct_dir}/tests/test_${argv2}/c_case/$ARGV[1]/case.sv ${sim_ct_dir}/work/$ARGV[1]_$ARGV[2]_$ARGV[3]");
    } 
    else{
        system("touch ${sim_ct_dir}/work/$ARGV[1]_$ARGV[2]_$ARGV[3]/case.sv");
    }


    #######################################################################
    # EDA sim
    #######################################################################
    chdir ("${sim_ct_dir}/work/$ARGV[1]_$ARGV[2]_$ARGV[3]");
    system ("make $ARGV[0] TEST_NAME=$ARGV[1] OPEN_CPU_TYPE=$ARGV[2] OPEN_CPU_MODE=$ARGV[3];sleep 15 &");


    #######################################################################
    # sim report
    #######################################################################
    #open sim log
    chdir("${sim_ct_dir}/work/$ARGV[1]_$ARGV[2]_$ARGV[3]"); 
    my $sim_log_file = "$ARGV[1]_$ARGV[2]_$ARGV[3].log";
    open my $sim_log_file_fh, '<', $sim_log_file or die "can not open log file!";
    
    #create report dir 
    if(!(-e "${sim_ct_dir}/regress/regress_result")) {
		system("mkdir ${sim_ct_dir}/regress/regress_result");
	}
    chdir("${sim_ct_dir}/regress/regress_result"); 
    my $sim_report_file = "$ARGV[1]_$ARGV[2]_$ARGV[3].rpt";
    open my $sim_report_file_fh, '>', $sim_report_file or die "can not open rpt file!";

    #case result
    my $case_result = "TEAT NA";
    while(<$sim_log_file_fh>) {
        if (/TEST__CASE__FAILED!/) {
            $case_result = "TEST FAIL";
            last;        
        }
        elsif(/TEST__CASE__PASSED!/) {
            $case_result = "TEST PASS";
            last;        
        }       
    }

    #write result
    print $sim_report_file_fh "$case_result\n";
    
    #close
    close $sim_log_file_fh;;
    close $sim_report_file_fh;

    #create regress_report
    chdir("${sim_ct_dir}/regress");
    system("perl gen_regress_report.pl");


    #######################################################################
    # cov
    #######################################################################




    #######################################################################
    # open sim log 
    #######################################################################
    chdir("${sim_ct_dir}/work/$ARGV[1]_$ARGV[2]_$ARGV[3]");
    if($ARGV[0] eq "asic" || $ARGV[0] eq "fpga") {
        system("gvim $ARGV[1]_$ARGV[2]_$ARGV[3].log");
    }



}
else {
    die "parameter is not correct!\n";
}


exit 0;					

