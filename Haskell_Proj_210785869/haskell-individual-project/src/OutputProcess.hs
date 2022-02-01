

-- | Module which contains output generation process

module OutputProcess(randomNum,mapForkMethod,upgradeInfo,yieldProcess 
                  ) where

import Datatypes 
import System.Random (randomIO,randomRIO, random)
import Control.Concurrent
import Control.Monad
import UserInfo
import Text.StringRandom
import Data.Text (pack)

randomNum :: Int -> IO Int  -- ^ Generate a random number  
randomNum maxVal = do 
    n <- randomIO 
    let to = mod n 100 + 1 
    return to

mapForkMethod :: MVar [User] -> MVar Int -> MVar Int -> [Int] -> IO () -- ^ Map for each number from 0 to 10
mapForkMethod users outcome total user_threads =
    forM_ user_threads $ \n ->    
    forkIO (yieldProcess n users outcome total)

upgradeInfo :: MVar a -> a -> IO () -- ^ Upgrade the information
upgradeInfo = putMVar

yieldProcess :: Int -> MVar [User] -> MVar Int -> MVar Int -> IO () -- ^ Send and receive the messages
yieldProcess u_num users outcome total = do
    sum <- takeMVar total
    enduser <- takeMVar users
    if sum == 100 then do
        putStrLn  "Process Completed" 
        putStrLn  "<<--------------------------------->>" 

        putMVar outcome u_num
        upgradeInfo users enduser 
        return ()
    else do
        
        
        to <- obtainUserId u_num
        let regex = pack "[a-z]{10,20}$"
        randStr <- stringRandomIO regex
        let message = Message {to=to, from=u_num, content=randStr}
        putStrLn $ "\n Message From: " ++ show u_num ++ "\n Message To: " ++ show to ++ "\n Message Content: " ++ show randStr

        let enduser' = map helper enduser
            helper x = upgradeUser x message
        let sum' = sum + 1
        putMVar total sum'
        putMVar users enduser'
        delayTime <- randomRIO (9500, 10000)  
        putStrLn $ "Random time inrterval is ==> " ++ show delayTime ++ " Millisecond"
        threadDelay delayTime 
        yieldProcess u_num users outcome total
        

