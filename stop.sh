echo -e "\nStopping swatch UI"
echo "======================="
docker container stop `cat ui.pid`

echo -e "\nStopping swatch server"
echo "==========================="
docker container stop `cat server.pid`
rm *.pid