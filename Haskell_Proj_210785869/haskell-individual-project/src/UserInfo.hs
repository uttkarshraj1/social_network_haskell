
-- | Module which contains User Information

module UserInfo(
                    obtainUser, createNewUser,upgradeUser,obtainUserId
                  ) where

import Datatypes 
import System.Random (randomIO)

obtainUser :: [User] -> Int -> User  -- ^ Obtain a user
obtainUser users id = users !! id

createNewUser :: Int -> User -- ^ Create a new userId
createNewUser id = User id 0 []

upgradeUser :: User -> Message -> User -- ^ Upgrade the user 
upgradeUser user message
    | u_num user == to message = user {msg_recived = msg_recived user + 1, user_msg = message : user_msg user}
    | u_num user == from message = user {user_msg = message : user_msg user}
    | otherwise = user  


obtainUserId :: Int -> IO Int  -- ^ Obtain id 
obtainUserId exclude_id = do
    n <- randomIO
    let to = mod n 10 + 1 
    if to == exclude_id then
        obtainUserId exclude_id
    else
        return to

