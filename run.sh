JAVA_MAJOR_VERSION=$(java -version 2>&1 | grep -oP 'version "?(1\.)?\K\d+' || true)
if [[ $JAVA_MAJOR_VERSION -lt 11 ]]; then
  echo -e "\nError: JDK 11 Required\n"
  echo -e "Found:\n"
  echo `java -version`
  exit 1
fi

echo "Downloading swatch server"
echo "========================="
git clone https://github.com/Random-Swatch/swatch-server.git

echo -e "\nDownloading swatch UI"
echo "========================="
git clone https://github.com/Random-Swatch/swatch-ui.git

cd swatch-server

echo -e "\nBuilding swatch server"
echo "======================"
mvn clean install
docker build -t swatch/server:0.0.1 .

echo -e "\n>> Starting swatch server"
docker run -p 8080:8080 -d swatch/server:0.0.1 >> ../server.pid

cd ../swatch-ui

echo -e "\nBuilding swatch UI"
echo "=================="
docker build -t swatch/ui:0.0.1 .

echo -e "\n>>> Starting swatch UI"
docker run -p 3000:3000 -d swatch/ui:0.0.1 >> ../ui.pid

echo -e "\nDone: http://localhost:3000/"

cd ..

rm -rf swatch-*