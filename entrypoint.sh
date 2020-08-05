#!/usr/bin/env bash

configs=$(grep -e '^plugin|' -e '^download|' -e '^copy|' -e '^mvn|' main.plugins)
for config in ${configs}; do
  if [[ "$config" == *"plugin"* ]]; then
    pValue=$(echo ${config} | cut -d'|' -f2)
    echo ${pValue}
    /jmeter/bin/PluginsManagerCMD.sh install ${pValue}
  elif [[ "$config" == *"download"* ]]; then
    sourceURL=$(echo ${config} | awk -F'|' '{print $2}')
    targetDir=$(echo ${config} | awk -F'|' '{print $3}')
    mkdir -p ${targetDir}
    curl ${sourceURL} -O ${targetDir}/$(basename sourceURL)
  elif [[ "$config" == *"copy"* ]]; then
    filePattern=$(echo ${config} | awk -F'|' '{print $2}')
    installPath=$(echo ${config} | awk -F'|' '{print $3}')
    cp ${filePattern} ${installPath}
  elif [[ "$config" == *"mvn"* ]]; then
    filePath=$(echo ${config} | cut -d'|' -f2)
    mvn install -f ${filePath}
  fi
done

sh jmeter/bin/jmeter -n -t main.jmx
