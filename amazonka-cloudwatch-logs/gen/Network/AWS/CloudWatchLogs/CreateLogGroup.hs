{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TypeFamilies      #-}

-- Module      : Network.AWS.CloudWatchLogs.CreateLogGroup
-- Copyright   : (c) 2013-2015 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
--
-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- | Creates a new log group with the specified name. The name of the log
-- group must be unique within a region for an AWS account. You can create
-- up to 500 log groups per account.
--
-- You must use the following guidelines when naming a log group:
--
-- -   Log group names can be between 1 and 512 characters long.
-- -   Allowed characters are a-z, A-Z, 0-9, \'_\' (underscore), \'-\'
--     (hyphen), \'\/\' (forward slash), and \'.\' (period).
--
-- <http://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_CreateLogGroup.html>
module Network.AWS.CloudWatchLogs.CreateLogGroup
    (
    -- * Request
      CreateLogGroup
    -- ** Request constructor
    , createLogGroup
    -- ** Request lenses
    , clgLogGroupName

    -- * Response
    , CreateLogGroupResponse
    -- ** Response constructor
    , createLogGroupResponse
    ) where

import           Network.AWS.CloudWatchLogs.Types
import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response

-- | /See:/ 'createLogGroup' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'clgLogGroupName'
newtype CreateLogGroup = CreateLogGroup'
    { _clgLogGroupName :: Text
    } deriving (Eq,Read,Show)

-- | 'CreateLogGroup' smart constructor.
createLogGroup :: Text -> CreateLogGroup
createLogGroup pLogGroupName =
    CreateLogGroup'
    { _clgLogGroupName = pLogGroupName
    }

-- | The name of the log group to create.
clgLogGroupName :: Lens' CreateLogGroup Text
clgLogGroupName = lens _clgLogGroupName (\ s a -> s{_clgLogGroupName = a});

instance AWSRequest CreateLogGroup where
        type Sv CreateLogGroup = CloudWatchLogs
        type Rs CreateLogGroup = CreateLogGroupResponse
        request = postJSON
        response = receiveNull CreateLogGroupResponse'

instance ToHeaders CreateLogGroup where
        toHeaders
          = const
              (mconcat
                 ["X-Amz-Target" =#
                    ("Logs_20140328.CreateLogGroup" :: ByteString),
                  "Content-Type" =#
                    ("application/x-amz-json-1.1" :: ByteString)])

instance ToJSON CreateLogGroup where
        toJSON CreateLogGroup'{..}
          = object ["logGroupName" .= _clgLogGroupName]

instance ToPath CreateLogGroup where
        toPath = const "/"

instance ToQuery CreateLogGroup where
        toQuery = const mempty

-- | /See:/ 'createLogGroupResponse' smart constructor.
data CreateLogGroupResponse =
    CreateLogGroupResponse'
    deriving (Eq,Read,Show)

-- | 'CreateLogGroupResponse' smart constructor.
createLogGroupResponse :: CreateLogGroupResponse
createLogGroupResponse = CreateLogGroupResponse'
