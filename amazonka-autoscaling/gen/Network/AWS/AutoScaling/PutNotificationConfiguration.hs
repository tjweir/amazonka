{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TypeFamilies      #-}

-- Module      : Network.AWS.AutoScaling.PutNotificationConfiguration
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

-- | Configures an Auto Scaling group to send notifications when specified
-- events take place. Subscribers to this topic can have messages for
-- events delivered to an endpoint such as a web server or email address.
--
-- For more information see
-- <http://docs.aws.amazon.com/AutoScaling/latest/DeveloperGuide/ASGettingNotifications.html Getting Notifications When Your Auto Scaling Group Changes>
-- in the /Auto Scaling Developer Guide/.
--
-- This configuration overwrites an existing configuration.
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_PutNotificationConfiguration.html>
module Network.AWS.AutoScaling.PutNotificationConfiguration
    (
    -- * Request
      PutNotificationConfiguration
    -- ** Request constructor
    , putNotificationConfiguration
    -- ** Request lenses
    , pncAutoScalingGroupName
    , pncTopicARN
    , pncNotificationTypes

    -- * Response
    , PutNotificationConfigurationResponse
    -- ** Response constructor
    , putNotificationConfigurationResponse
    ) where

import           Network.AWS.AutoScaling.Types
import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response

-- | /See:/ 'putNotificationConfiguration' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'pncAutoScalingGroupName'
--
-- * 'pncTopicARN'
--
-- * 'pncNotificationTypes'
data PutNotificationConfiguration = PutNotificationConfiguration'
    { _pncAutoScalingGroupName :: Text
    , _pncTopicARN             :: Text
    , _pncNotificationTypes    :: [Text]
    } deriving (Eq,Read,Show)

-- | 'PutNotificationConfiguration' smart constructor.
putNotificationConfiguration :: Text -> Text -> PutNotificationConfiguration
putNotificationConfiguration pAutoScalingGroupName pTopicARN =
    PutNotificationConfiguration'
    { _pncAutoScalingGroupName = pAutoScalingGroupName
    , _pncTopicARN = pTopicARN
    , _pncNotificationTypes = mempty
    }

-- | The name of the Auto Scaling group.
pncAutoScalingGroupName :: Lens' PutNotificationConfiguration Text
pncAutoScalingGroupName = lens _pncAutoScalingGroupName (\ s a -> s{_pncAutoScalingGroupName = a});

-- | The Amazon Resource Name (ARN) of the Amazon Simple Notification Service
-- (SNS) topic.
pncTopicARN :: Lens' PutNotificationConfiguration Text
pncTopicARN = lens _pncTopicARN (\ s a -> s{_pncTopicARN = a});

-- | The type of event that will cause the notification to be sent. For
-- details about notification types supported by Auto Scaling, see
-- DescribeAutoScalingNotificationTypes.
pncNotificationTypes :: Lens' PutNotificationConfiguration [Text]
pncNotificationTypes = lens _pncNotificationTypes (\ s a -> s{_pncNotificationTypes = a});

instance AWSRequest PutNotificationConfiguration
         where
        type Sv PutNotificationConfiguration = AutoScaling
        type Rs PutNotificationConfiguration =
             PutNotificationConfigurationResponse
        request = post
        response
          = receiveNull PutNotificationConfigurationResponse'

instance ToHeaders PutNotificationConfiguration where
        toHeaders = const mempty

instance ToPath PutNotificationConfiguration where
        toPath = const "/"

instance ToQuery PutNotificationConfiguration where
        toQuery PutNotificationConfiguration'{..}
          = mconcat
              ["Action" =:
                 ("PutNotificationConfiguration" :: ByteString),
               "Version" =: ("2011-01-01" :: ByteString),
               "AutoScalingGroupName" =: _pncAutoScalingGroupName,
               "TopicARN" =: _pncTopicARN,
               "NotificationTypes" =:
                 toQueryList "member" _pncNotificationTypes]

-- | /See:/ 'putNotificationConfigurationResponse' smart constructor.
data PutNotificationConfigurationResponse =
    PutNotificationConfigurationResponse'
    deriving (Eq,Read,Show)

-- | 'PutNotificationConfigurationResponse' smart constructor.
putNotificationConfigurationResponse :: PutNotificationConfigurationResponse
putNotificationConfigurationResponse = PutNotificationConfigurationResponse'
