#####################################################################################################
#                       LINKS & TUTORIALS                                                           #
#                                                                                                   #
#   Homepage    https://vpl.dis.ulpgc.es                                                            #
#   Tutorial    https://vpl.dis.ulpgc.es/index.php/support                                          #
#   Forum       https://moodle.org/mod/forum/view.php?id=8672                                       #
#   Scripts     https://github.com/jcrodriguez-dis/moodle-mod_vpl/blob/master/jail/default_scripts  #
#                                                                                                   #
#####################################################################################################

# # coreclr-27955-workaround.c
# # A workaround to fix a bug in dotnet 5
# # https://github.com/dotnet/runtime/issues/13475#issuecomment-559854433
# echo "int sched_getcpu(void) {" > coreclr-27955-workaround.c
# echo "    return 0;" >> coreclr-27955-workaround.c
# echo "}" >> coreclr-27955-workaround.c
# gcc -shared -fPIC coreclr-27955-workaround.c -o libcoreclr-27955-workaround.so
# LD_PRELOAD=/usr/local/lib/libcoreclr-27955-workaround.so

##### load common script and check that python is installed
. common_script.sh
check_program python3

# end of general preparations.
########################################################################################################

# get student files
rm -rf submission
mkdir submission
unzip -q $VPL_SUBFILES -d submission

# creates an environment variable, called SOURCE_FILES, with all py files in the directory + subdirctories
get_source_files py

dll_files=$(printf '%s\n' "${SOURCE_FILES[@]}" | grep -P '^submission/*.py$')
# Get the grading project
test_files=$(printf '%s\n' "${SOURCE_FILES[@]}" | grep -P '^FunctionalTesting/.*$')

#remove reference to Kanban.csproj from FunctionalTesting.csproj
# dotnet remove $test_files reference "..\Backend\Backend.csproj"

# prepare output directory
rm -rf output
mkdir output

#echo "Restore testing project..."
##$PROGRAM restore $test_files
#echo "Build testing project..."
#$PROGRAM build $test_files -o output/FunctionalTesting | grep -v 'warning'
#echo "Finished building testing project..."

echo 'pip3 install pandas' > vpl_execution
# echo 'cd submission' > vpl_execution
echo 'echo | ls' >> vpl_execution
echo 'python3 submission/TestsTemplateFile.py' >> vpl_execution

# echo 'echo | ls' >> vpl_execution
echo 'cd submission' >> vpl_execution
echo 'temp="$(cat student_summation.txt)"' >> vpl_execution

# while IFS= read -r line
# do
#   'echo "Comment :=>> line"'
# done < <(printf '%s\n' "$var")

echo 'echo "Comment :=>> $temp"' >> vpl_execution


chmod +x vpl_execution



# echo 'cd submission' > vpl_execution
# echo 'echo | ls' >> vpl_execution

# if [ -f submission/solution.py]; then
# 	echo 'echo "found student solution file..."' > vpl_execution
# else
# 	echo 'echo "not found student submission file"' > vpl_execution
# fi

# chmod +x vpl_execution
