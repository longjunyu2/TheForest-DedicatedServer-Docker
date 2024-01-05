# TheForest-DedicatedServer-Docker
## Build
Build base image. There's only server files in this image.
```shell
cd base
docker build -t <base_image_name> .
```
Then build final image. There's a startup shell script to start the server.
```shell
cd server
docker build -t <final_image_name> .
```
The default `<base_image_name>` is `longjunyu/theforest-base`.</br>
If you want to use another name, don't forget to change to first line of `server/Dockerfile` to the one you set. `FROM <base_image_name_you_set>`

## Run
Before creating the container, you need create a file for config and a folder for saves.</br>
Here is a tutorial about how to creating the config file. [Dedicated Server Tutorial](https://steamcommunity.com/sharedfiles/filedetails/?id=907906289&searchtext=delicated+server)</br></br>
docker cli
```shell
docker run -d \
    --name=<container_name> \
    --net=host \
    -v <path_to_config>:/data/config/config.cfg \
    -v <path_to_saves>:/data/config/saves \
    <final_image_name>
```
There's some issues with bridge network mode. You will meet ```DS configurations tests: failed``` and the server WON'T startup
```shell
docker run -d \
    --name=<container_name> \
    --net=bridge \
    -p 8766:8766/udp \
    -p 27015:27015/udp \
    -p 27016:27016/udp \
    -v <path_to_config>:/data/config/config.cfg \
    -v <path_to_saves>:/data/config/saves \
    <final_image_name>
```

## Other Parameters
There are also some additional parameters that can be set to the container.
| Parameter | Function |
|  ----  | ----  |
| ```-e USER_ID=1000```  | for UserID  - see below for explanation |
| ```-e GROUP_ID=1000```  | for GroupID  - see below for explanation |
| ```-e TZ=Asia/Shanghai``` | specify a timezone to use, see this [list](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List). |

## User / Group Identifiers
When using volumes (-v flags), permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user PUID and group PGID.</br></br>
Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish.</br>
In this instance USER_ID=1000 and GROUP_ID=1000, to find yours use id your_user as below:</br>
```id <your_user>```</br>
Example output:</br>
```uid=1000(your_user) gid=1000(your_user) groups=1000(your_user)```
    
