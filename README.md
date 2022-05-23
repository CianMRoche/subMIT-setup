# How do we interface with the computing resources?

We have two choices for interfacing with the computing resources of the subMIT cluster:
1. Command line (terminal)
2. An integrated development environment (IDE)

Command line is simplest, but IDEs offer useful quality-of life features. We will discuss how to set up both. In eitehr case, the protocols for communicating between your PC and the cluster are handled by "SSH" (Secure SHell) which we'll explain briefly now.

### Note
I will use `/home/` for home directories. On MAC or linux this can be represented by a tilde "~" and in Windows it will likely be `C:\Users\windows_username\` 

# How to connect remotely
1. The first step is to set up SSH on your computer, which replaces the need for a "sign-in"-like procedure. The idea is that we generate a **public key** and a **private key** on our pc. The public key is used by the service we want to connect securely to, so we must give that service our public key in advance. That key is used to _encrypt_ the message. The private key we keep for ourselves, and it is accessed by our computer when we try to decrypt an encrypted message received via ssh.
To generate a public key and private key pair, open a terminal (use a powershell if on windows) and run the command
`ssh-keygen` in your terminal

2. You can set a password if you like, and you should use the default directories, which look like `/home/username/.ssh/` where "username" replaces the username of the account you're using on your PC. Check this directory to make sure you have files like `id_rsa` (the private key) and `id_rsa.pub` (the public key). Open the public key with a text editor of any kind and copy all the contents.

3. Next go to the subMIT portal at https://submit-portal.mit.edu/, sign in, and make sure it says your kerberos username under "Username". Click on "SSH Keys", paste in your **public key** and update. It may take up to 15 minutes (or longer?) for this to update in their system. 

4. When you want to connect a terminal to the cluster, now all you need to do is type 
`ssh kerberos_username@submit.mit.edu`
where you replace "kerberos_username" with your kerberos username. Type "yes" if prompted to and hit enter, and you should see a new terminal which has an interface like `-bash-4.2:` which lets you know we are using a BASH shell. My kerberos username is "roche" so I will do the following[^1]: 
<p align="center">
  <img width="314" alt="ssh" src="https://user-images.githubusercontent.com/29131312/169733063-e79e4b3e-28f1-44e1-abff-e86af3cbe4a5.png">
</p>

5. If you want to reduce the amount of typing you do even further, create a file named "config" in `/home/.ssh/` with the following contents, where you again replaces kerberos_username with your kerberos username.
```
Host submit
    HostName submit.mit.edu 
    User kerberos_username
```
If you would prefer, you can also pull and edit an example config file from this repo by running the command `wget https://raw.githubusercontent.com/CianMRoche/subMIT-setup/main/config` **from the home/.ssh/ directory** and editing the kerberos username in a command line text editor like vim. To do so, run `vim config`, press "i" for insert mode, navigate the cursor to the username field and edit to your kerberos username, press "Esc", type ":wq" and then press enter (saves and quits).

6. Now you can connect to subMIT by simply typing `ssh submit` and you will be signed in as usual
<p align="center">
  <img width="227" alt="ssh_config" src="https://user-images.githubusercontent.com/29131312/169733647-63923825-abad-440a-ab86-2d1dae1f4a7b.png">
</p>


[^1]: Shown is a Windows powershell instance

# If you want to use an IDE: Connecting remotely in Visual Studio Code

### Warning: This potentially adds some complexity and jupyterlab (used later in the "jupyter notebooks" section proviodes some of the same functionality)
VSCode is an IDE that can be very useful, and will serve as the example for using an IDE. This section requires the previous section being already completed, in particular that you have created the "config" file of step 5.

1. Install visual studio code in whatever form is appropriate for your system
2. Go to the extensions manager (click squares on left hand side of VSCode) and search for & install both ‘Project manager’ and ‘Remote Development’ which look like this:

<p align="center">
    <img width="243" alt="package1" src="https://user-images.githubusercontent.com/29131312/169737302-6daa8400-0ef4-4ab5-8f81-b311a16fe540.png">
  </p>
<p align="center">
    <img width="241" alt="package2" src="https://user-images.githubusercontent.com/29131312/169737315-27a42b0d-2e4e-4a15-ba39-4c2202b4b1d5.png">
  </p>

3. Go to File > preferences > settings > search for ‘remote.ssh show login terminal’ and make sure that setting box is checked
<p align="center">
    <img width="454" alt="arrows" src="https://user-images.githubusercontent.com/29131312/169739219-f6f536f5-b371-48cf-aa22-efcae461ebf0.png">
  </p>

4. Click ‘connect to host’ in the remote-ssh menu

5. If you used the default location for your ‘config’ file, then vs code should see it and you should see "submit" as an option (the name we gave our host in the config file).

<p align="center">
    <img width="448" alt="vscode_ssh" src="https://user-images.githubusercontent.com/29131312/169739682-bbb0e166-c77a-4685-86e0-5b4b80feaf4f.png">
  </p>
If you don’t see "submit" as an option, click ‘configure ssh hosts’ and direct it to your config file from earlier (perhaps via ‘specify a custom configuration file’). For more help, click the green button on the bottom left, then ‘getting started with SSH’.

6. We are by default in the home directory. In reality we will use the "work" directory most often, as we have more storage available there. On the top left in VSCode, click File, Open Folder, and go to `/work/submit/kerberos_username` where you replace kerberos_username as appropriate. Click on the project manager icon on the left and then click the save icon. Name this project "subMIT" or "subMIT work" or similar. From now on clicking on this project in the project manager will take you to the "work" folder of your subMIT allocation. You can interface with the home directory via the terminals integrated into VSCode (open via the "+" near the bottom-right or by pressing " Ctrl + Shift + ` " where ` is probably the key left of the number 1 on your keyboard) or by changing the open folder as we did a moment ago.
<p align="center">
    <img width="234" alt="project" src="https://user-images.githubusercontent.com/29131312/169740816-4ebc0bd0-5eb1-4487-896b-d28248b1457e.png">
  </p>
7. You can now create and edit files on the subMIT cluster using the VSCode interface or via any terminal as in the previous section. The rest of the setup will take place in the home directory, but we will eventually not use it very often.

# Making the BASH terminal interface a little nicer
A `home/.bashrc` file is used to change the functionality and appearance of BASH terminals, so we can add one and add useful aliases and so on as we work. There is a `.bashrc` file available on this repo, so one could either make and edit a file called `.bashrc` in their home directory or pull it directly via a terminal connected to subMIT (and in their home directory) by running

```wget https://raw.githubusercontent.com/CianMRoche/subMIT-setup/main/.bashrc```

Then if that .bashrc file is used, the next time one connects to subMIT via a new terminal, the interface should be slightly different and look like: 
<p align="center">
    <img width="191" alt="bashrc_new" src="https://user-images.githubusercontent.com/29131312/169744360-96ff7735-c9b1-4867-bc7a-bb1950bfabe4.png">
  </p>
Note that the "06" above just refers to which computing node we have been logged into, and may change with new logins.

# Setting up an Anaconda Environment
We will use python for most of our analysis (though other languages likely _can_ be used on subMIT, we will be less capable of support for languages other than Python). To streamline the process of getting packages, we will install miniconda (a lightweight version of anaconda which also uses the "conda" package manager).
1. To download miniconda, from the home directory run `wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh`
2. To install miniconda, run `bash Miniconda3-latest-Linux-x86_64.sh` and press (/hold) enter or type "yes" as required. **Important**: when you are prompted with
```
Do you wish the installer to initialize Miniconda3
by running conda init? [yes|no]
```
make sure to type "yes" and hit enter. This adds lines to to your .bashrc file such that you automatically activate your base conda environment when opening a new terminal. If you missed it, then type `eval "$(/home/submit/roche/miniconda3/bin/conda shell.bash hook)"` followed by `conda init` then open a new terminal. After opening a new terminal, you should see the name of your conda environment (currently "base") as follows:
<p align="center">
    <img width="178" alt="base" src="https://user-images.githubusercontent.com/29131312/169746015-6ee15154-ca23-4877-83fb-6fc35e595209.png">
  </p>

3. Now that miniconda is installed and we are in our base environment, lets make a new environment with some packages that we will likely need. There is a file containing a list of packages and versions in this repo called "py3.yml" and we will use this as a good starting point. If you need any other packages later, simply activate this environment and run `conda install _ ` where _ represents the package of interest. To download the file, run `wget https://raw.githubusercontent.com/CianMRoche/subMIT-setup/main/py3.yml` from the home directory.
4. To make our environment (which we will give the name "py3") run `conda env create -f py3.yml` and let the installer finish, which can take quite a while.
5. To activate the environment, run “conda activate py3” and you should see (base) turn to (py3) in your terminal. I typically add a line to my .bashrc which lets me type `env` that automatically activates my usual conda environment. Such a line is `alias env="conda activate py3"` and is included in the .bashrc from the previous section. simply typing `env` in the terminal will activate this "py3" environment.
<p align="center">
    <img width="176" alt="env" src="https://user-images.githubusercontent.com/29131312/169749228-1b7254f7-3611-486f-aa75-7ea243235dc3.png">
  </p>

# Jupyter notebooks
We can use jupyter notebooks using kernels from our subMIT anaconda environments by going to https://submit00.mit.edu/jupyter . In the launcher you should see an option for a "py3" notebook, which would correspond to our anaconda environment.
<p align="center">
    <img width="1278" alt="jupyterlab2" src="https://user-images.githubusercontent.com/29131312/169751583-2577341f-bad9-47ee-8d7e-ab47fa16029c.png">
  </p>

If this works, spend some time getting used to the jupyterlab interface! Try going to "Help > Jupyter reference" as a good place to start. If you dont see that option, try refreshing the page. If that doesnt fix it, ask for help!

### Doing so in VSCode
Using jupyter notebooks in a VSCode instance requires going to the extension manager on the left (of a remote VSCode instance which is connected to subMIT) and installing the "python" and "jupyter" extensions (and installing any others for which you are prompted on the bottom right when trying to start a kernel in a notebook). Upon doing so, you can quickly create a file such as `test.ipynb` and select a kernel on the top right. If all is working as expected, your list of kernels should be similar to the following:
<p align="center">
    <img width="1277" alt="notebookVSCode" src="https://user-images.githubusercontent.com/29131312/169750342-fcbe2ab0-c1cd-4ec5-925d-0b4068e2d3a1.png">
  </p>
  
As you may expect, "base" is the base conda environment, and "py3" is the one we created.
