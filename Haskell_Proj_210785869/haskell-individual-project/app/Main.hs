
-- | Main module

module Main where

import Control.Concurrent
import Control.Monad
import System.Random (randomIO,randomRIO, random)
import Text.StringRandom
import Data.Text (pack)
import Datatypes 
import UserInfo (createNewUser,  obtainUser, upgradeUser , obtainUserId)
import OutputProcess (randomNum,mapForkMethod,upgradeInfo,yieldProcess)

-- ^ Main function, the start and end point of the program
main :: IO () -- ^ Performs an IO action
main = do
            total <- newMVar 0
            outcome <- newEmptyMVar
            users <- newMVar (map createNewUser [1..10]) 
            
            mapForkMethod users outcome total [1..10]
            w <- takeMVar outcome
            enduser <- takeMVar users
            mapM_ printMessageOutput enduser


printMessageOutput :: User -> IO () -- ^ Print output for the users receiving messages
printMessageOutput user = putStrLn $ "User " ++ show (u_num user) ++ " has received " ++ show (msg_recived user) ++ " messages"






