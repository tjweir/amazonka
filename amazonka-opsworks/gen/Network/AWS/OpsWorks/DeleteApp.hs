{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TypeFamilies      #-}

-- Module      : Network.AWS.OpsWorks.DeleteApp
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

-- | Deletes a specified app.
--
-- __Required Permissions__: To use this action, an IAM user must have a
-- Manage permissions level for the stack, or an attached policy that
-- explicitly grants permissions. For more information on user permissions,
-- see
-- <http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html Managing User Permissions>.
--
-- <http://docs.aws.amazon.com/opsworks/latest/APIReference/API_DeleteApp.html>
module Network.AWS.OpsWorks.DeleteApp
    (
    -- * Request
      DeleteApp
    -- ** Request constructor
    , deleteApp
    -- ** Request lenses
    , daAppId

    -- * Response
    , DeleteAppResponse
    -- ** Response constructor
    , deleteAppResponse
    ) where

import           Network.AWS.OpsWorks.Types
import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response

-- | /See:/ 'deleteApp' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'daAppId'
newtype DeleteApp = DeleteApp'
    { _daAppId :: Text
    } deriving (Eq,Read,Show)

-- | 'DeleteApp' smart constructor.
deleteApp :: Text -> DeleteApp
deleteApp pAppId =
    DeleteApp'
    { _daAppId = pAppId
    }

-- | The app ID.
daAppId :: Lens' DeleteApp Text
daAppId = lens _daAppId (\ s a -> s{_daAppId = a});

instance AWSRequest DeleteApp where
        type Sv DeleteApp = OpsWorks
        type Rs DeleteApp = DeleteAppResponse
        request = postJSON
        response = receiveNull DeleteAppResponse'

instance ToHeaders DeleteApp where
        toHeaders
          = const
              (mconcat
                 ["X-Amz-Target" =#
                    ("OpsWorks_20130218.DeleteApp" :: ByteString),
                  "Content-Type" =#
                    ("application/x-amz-json-1.1" :: ByteString)])

instance ToJSON DeleteApp where
        toJSON DeleteApp'{..} = object ["AppId" .= _daAppId]

instance ToPath DeleteApp where
        toPath = const "/"

instance ToQuery DeleteApp where
        toQuery = const mempty

-- | /See:/ 'deleteAppResponse' smart constructor.
data DeleteAppResponse =
    DeleteAppResponse'
    deriving (Eq,Read,Show)

-- | 'DeleteAppResponse' smart constructor.
deleteAppResponse :: DeleteAppResponse
deleteAppResponse = DeleteAppResponse'
