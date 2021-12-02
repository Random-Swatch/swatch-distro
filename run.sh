echo "Downloading swatch server"
echo "========================="
git clone git@github.com:Random-Swatch/swatch-server.git

echo -e "\nDownloading swatch UI"
echo "========================="
git clone git@github.com:Random-Swatch/swatch-ui.git

cd swatch-server

echo -e "\nBuilding swatch server"
echo "======================"
docker build -t swatch/server:0.0.1 .

echo -e "\n>> Starting swatch server"
docker run -p 8080:8080 --name swatch_server -d swatch/server:0.0.1 &

cd ../swatch-ui

echo -e "\nBuilding swatch UI"
echo "=================="
docker build -t swatch/ui:0.0.1 .

echo -e "\n>>> Starting swatch UI"
docker run -p 3000:3000 --name swatch_ui -d swatch/ui:0.0.1 &

echo -e "\nDone"
