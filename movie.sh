echo "Generating projects"

read -p 'Input Type <xcodegen, deintegrate> | enter for all command: ' command

if [[ "$command" = "xcodegen" ]]
then
    xcodegen -s ./Core/project.yml
    xcodegen -s ./ModuleManagement/project.yml
    xcodegen -s ./MovieKit/project.yml
    xcodegen -s ./MovieDetail/project.yml
    xcodegen -s ./Networking/project.yml
    xcodegen -s ./MovieList/project.yml
    xcodegen -s ./RxFramework/project.yml
    xcodegen -s ./project.yml
elif [[ "$command" = "deintegrate" ]]
then
    pod deintegrate MovieDB.xcodeproj   
else 
    pod deintegrate MovieDB.xcodeproj   

    xcodegen -s ./Core/project.yml
    xcodegen -s ./ModuleManagement/project.yml
    xcodegen -s ./MovieKit/project.yml
    xcodegen -s ./MovieDetail/project.yml
    xcodegen -s ./Networking/project.yml
    xcodegen -s ./MovieList/project.yml
    xcodegen -s ./RxFramework/project.yml
    xcodegen -s ./project.yml
fi