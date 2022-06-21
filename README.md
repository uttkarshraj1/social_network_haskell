# Social Network Haskell

Directions to run and compile the code :

1) Step 1 => To run/compile the code, open the project folder using VS code.

2) Step 2 => Then go into the main project directory by using the command ‘cd haskell-
individual-project'

3) Step 3 => Then to build the project run the command ‘stack build’
 
4) Step 4 => Now after the project is built, run the command ‘stack run’ to execute the code and its output.

**Note:** This project will run concurrently.
Functioning of the project (Design Justification) : => The App has 4 modules including (main.hs)

UserInfo.hs = Module which contains User Information 

OutputProcess.hs = Module which contains output generation process 

Datatypes.hs = Module which contains the User and Message datatype

a) In this project I have implemented a Haskell project that is using thread and concurrent computation.

b) In this app at random intervals, the thread is selecting one of the other users randomly and then sends a random message to that user.

c) After the app is executed, I am making sure that every user is receiving the message and the total count of all the message is coming to ‘100’
