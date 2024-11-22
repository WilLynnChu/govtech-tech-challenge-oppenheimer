#Create virtual env
python3 -m venv oppenheimer

#Activate virtual env
source oppenheimer/bin/activate

#Install packages in requirements.txt
pip install -r requirements.txt

#Test case directory
directory="test-cases"

#File pattern to match
pattern="$1*"

#Variable to store matched file name
file_name_with_directory=""

#Get file name in test case directory
for file in "$directory"/$pattern; do
  if [ -f "$file" ]; then
    file_name_with_directory="$file"
    break
  fi
done

#Remove directory and extension for test report and test archive naming
filename=$(basename "$file_name_with_directory" .robot)

#Timestamp to be added in test archive folder
timestamp=$(date "+%Y%m%d-%H%M%S")

report_dir=./reports
archive_dir=./test-archives

#Clear reports folder
rm -rf ./reports

#Run test
robot --outputdir $report_dir -o output-$filename.xml -l log-$filename.html -r report-$filename.html $file_name_with_directory

#Copy reports to test archive folder
mkdir -p $archive_dir/$filename-$timestamp/
cp -r $report_dir/* $archive_dir/$filename-$timestamp/

#Deactivate virtual env
deactivate