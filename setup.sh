echo "                   _                      _                   "             
echo "      ___ ___   __| | ___  __ _  ___ _   _| |  _   _  __ ___   ___ "
echo "     / __/ _ \ / _\ |/ _ \/ _\  / __| | | | ||  | | ||_ | _ \ / __| " 
echo "    | (_| (_) | (_| |  __/ (_|  \__ \ |_| | ||  |_| || | | | |\__ \ "
echo "     \___\___/ \__/_|\___|\__/'_|___/\__  |_| \__  _|| |_| |_||___) "
echo "                                    |___/ "

echo -e "\n\e[96mMachine Learning Bootcamp Kit\e[0m\n"
echo -e " \e[1m\e[33mNote : \e[0m\e[1mPlease select 1 if you're running this script first time. \e[0m"

PS3='Please enter your choice [1, 2, 3, 4] : '
options=("Setup" "Start" "Stop" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Setup")
            echo -e "\e[94myou chose choice $REPLY \e[0m"
            if [ -x "$(command -v docker-compose)" ]; then
                cd machine-learning 
                sudo docker-compose up -d && sudo  docker container logs jupyter &> jupyter_logs.txt
                cat jupyter_logs.txt | grep  -o -m 1 'http://127.0.0.1:8888/[a-zA-Z0-9.,-+=]*' > jupyter_url.txt
                xargs bash -c 'x-www-browser $@ &' null  < jupyter_url.txt &
                break
            else
                echo -e "\e[96mDocker Is Not Installed ..... > Installing docker\e[0m"
                sudo apt update
                sudo apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
                sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
                sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
                sudo apt update
                sudo apt install -y docker-ce docker-compose
                echo -e "\e[92mInstallation Complete\e[0m"
                cd machine-learning 
                sudo docker-compose up -d && sudo  docker container logs jupyter &> jupyter_logs.txt
                cat jupyter_logs.txt | grep  -o -m 1 'http://127.0.0.1:8888/[a-zA-Z0-9.,-+=]*' > jupyter_url.txt
                xargs bash -c 'x-www-browser $@ &' null  < jupyter_url.txt &
                break  
            fi
            break
            ;;
        "Start")
            echo -e "\e[94mStarting Jupyter \e[0m"
            cd machine-learning 
            sudo docker-compose up -d  &&  x-www-browser 127.0.0.1:8888
            echo -e "\e[92mJupyter successfully started\e[0m"
            break
            ;;
        "Stop")
            echo -e "\e[94mStoping Jupyter \e[0m"
            cd machine-learning
            sudo docker-compose down
            echo -e "\e[92mJupyter successfully stopped\e[0m"
            break
            ;;
        "Quit")
            echo -e  " \e[92mExit Successfully \e[0m"
            break
            ;;
        *) echo -e  " \e[91minvalid option $REPLY\e[0m  ::::: \e[93mPlease select valid option\e[0m";;
    esac
done

