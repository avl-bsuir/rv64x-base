<h1 align="center">
  <br>
  <a href="https://static.wixstatic.com/media/841f2a_ec3de0c290c14fddb9f4c3e90d85d9d6~mv2.png"><img src="https://static.wixstatic.com/media/841f2a_ec3de0c290c14fddb9f4c3e90d85d9d6~mv2.png" alt="RV64X" width="200"></a>  <br>
  <br>
</h1>

<h4 align="center">RV64X aims at creating and offering open-source GPUs with a RISC-V-derived architecture.</h4>

<p align="center">
  <a href="https://join.slack.com/t/rv64x/signup"></a>
  <a href="https://join.slack.com/t/rv64x/signup"><img src="https://static.wixstatic.com/media/841f2a_704ce8b0a76e42349eebbe2ba74b285c~mv2.png"></a>
</p>


<p align="center">
  <a href="#about">About the project</a> •
  <a href="#key-features">Key features</a> •
  <a href="#development-environment-setup">Development environment setup</a> •
  <a href="#contact">Contact</a> •
  <a href="#license">License</a>
</p>

# About the project
We want to enable small companies to develop purpose-built processors and GPUs without paying a royalty. There are numerous free and commercial IP building blocks for RISC-V-based system-on-chips (SoCs), but the portfolio lacks a graphics option so we decided to develop and offer open-source GPUs based on the RISC-V architecture.  

# Key Features
RV64X-designed GPUs use a basic RV32I or RV64I core that supports new instructions built on the base vector instruction set. Initially, it will use an RV32I core, and later on, an RV64I core will replace it. The basic RISC-V core will support:

1. New graphics and machine learning specific data types, including scalars and matrices;
2. Vector/math instructions; 
3. Pixel/texture instructions; 
4. Frame buffer instructions; 
5. Vector registers fully compatible with the RISC-V vector extension;
5. Some graphics-specific instructions; 

The graphics core will support the Vulkan API, but the group strives to make it DirectX (shader model 5) and OpenGL/ES-compliant. :smile:  

# Development environment setup

We use a docker image for easing the development environment setup for everyone wishing to contribute. There are four kinds of projects that are needed for doing RV64X development. Those projects are categorized in four levels, listed here in decreasing involvement by the RV64X organization:

1) Projects of which the RV64X organization has full ownership. They go into the /home/user/rv64x-project docker image directory included as a regular directories. They get versioned in the GitHub project under the ```https://github.com/rv64x/rv64x-base``` URL.

2) Projects to which RV64X contributes without owning their full code base, like QEMU and LLVM. Those projects go under /home/user/rv64x-base included as git submodules rather than as regular directories. For each of those projects the RV64X organization owns a “fork” repo that stays reasonably in sync with the original repo for easing the flow of changes going upstream and downstream.

3) Projects on which RV64X has no involvement, but we still want to build from source because suitable binary packages are not available. Those projects get fetched into /home/user/ and built during the scripted docker build. In case of an update need the whole docker image is rebuilt.

4) Projects in which RV64X has no involvement at all, neither we want to know how they are built because suitable binary packages are available. Those packages get installed with the likes of ```apt-get```, ```pip``` and ```npm``` at docker image build time.

The developer starts by recursively cloning the rv64x-base git repo for fetching projects from categories 1 and 2:

```git clone https://github.com/rv64x/rv64x-base --recursive```

Then you build the docker image, which provides all the dependencies from categories 3 and 4:

```source docker/build.sh```

You are now ready to have fun developing inside of the docker image by launching it as:

```source docker/run.sh```

Any changes on the ```/home/user/rv64x-base``` docker directory persist, but everything else is lost when you exit the docker. Actually, the ```rv64x-base``` docker directory maps to the host machine directory where you did the git clone. This is your work directory and everything else is just “The Matrix”, so to speak.

Inside of the docker you are ```user```, with ```user``` also being your password for ```sudo```. If you need to install a package (that will be lost when the session is closed) you can just do:

```sudo apt-get install my_package```

Also you can open additional shell sessions through ssh on port 2222 as:

```ssh user@localhost -p 2222```

Finally, you can start a vncserver inside of the docker and connect from the host machine port 5901. Through this vnc connection method you can use any GUI application that is required inside of the docker environment.

# Contact

Contact [Atif Zafar](https://github.com/atifzafar15) for more details.

# License

RV64X is BSD-style licensed, as found in the [LICENSE](LICENSE) file.
