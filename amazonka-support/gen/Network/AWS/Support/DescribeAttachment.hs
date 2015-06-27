{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TypeFamilies      #-}

-- Module      : Network.AWS.Support.DescribeAttachment
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

-- | Returns the attachment that has the specified ID. Attachment IDs are
-- generated by the case management system when you add an attachment to a
-- case or case communication. Attachment IDs are returned in the
-- AttachmentDetails objects that are returned by the
-- DescribeCommunications operation.
--
-- <http://docs.aws.amazon.com/awssupport/latest/APIReference/API_DescribeAttachment.html>
module Network.AWS.Support.DescribeAttachment
    (
    -- * Request
      DescribeAttachment
    -- ** Request constructor
    , describeAttachment
    -- ** Request lenses
    , daAttachmentId

    -- * Response
    , DescribeAttachmentResponse
    -- ** Response constructor
    , describeAttachmentResponse
    -- ** Response lenses
    , darAttachment
    , darStatus
    ) where

import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response
import           Network.AWS.Support.Types

-- | /See:/ 'describeAttachment' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'daAttachmentId'
newtype DescribeAttachment = DescribeAttachment'
    { _daAttachmentId :: Text
    } deriving (Eq,Read,Show)

-- | 'DescribeAttachment' smart constructor.
describeAttachment :: Text -> DescribeAttachment
describeAttachment pAttachmentId =
    DescribeAttachment'
    { _daAttachmentId = pAttachmentId
    }

-- | The ID of the attachment to return. Attachment IDs are returned by the
-- DescribeCommunications operation.
daAttachmentId :: Lens' DescribeAttachment Text
daAttachmentId = lens _daAttachmentId (\ s a -> s{_daAttachmentId = a});

instance AWSRequest DescribeAttachment where
        type Sv DescribeAttachment = Support
        type Rs DescribeAttachment =
             DescribeAttachmentResponse
        request = postJSON
        response
          = receiveJSON
              (\ s h x ->
                 DescribeAttachmentResponse' <$>
                   (x .?> "attachment") <*> (pure (fromEnum s)))

instance ToHeaders DescribeAttachment where
        toHeaders
          = const
              (mconcat
                 ["X-Amz-Target" =#
                    ("AWSSupport_20130415.DescribeAttachment" ::
                       ByteString),
                  "Content-Type" =#
                    ("application/x-amz-json-1.1" :: ByteString)])

instance ToJSON DescribeAttachment where
        toJSON DescribeAttachment'{..}
          = object ["attachmentId" .= _daAttachmentId]

instance ToPath DescribeAttachment where
        toPath = const "/"

instance ToQuery DescribeAttachment where
        toQuery = const mempty

-- | The content and file name of the attachment returned by the
-- DescribeAttachment operation.
--
-- /See:/ 'describeAttachmentResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'darAttachment'
--
-- * 'darStatus'
data DescribeAttachmentResponse = DescribeAttachmentResponse'
    { _darAttachment :: Maybe Attachment
    , _darStatus     :: !Int
    } deriving (Eq,Read,Show)

-- | 'DescribeAttachmentResponse' smart constructor.
describeAttachmentResponse :: Int -> DescribeAttachmentResponse
describeAttachmentResponse pStatus =
    DescribeAttachmentResponse'
    { _darAttachment = Nothing
    , _darStatus = pStatus
    }

-- | The attachment content and file name.
darAttachment :: Lens' DescribeAttachmentResponse (Maybe Attachment)
darAttachment = lens _darAttachment (\ s a -> s{_darAttachment = a});

-- | FIXME: Undocumented member.
darStatus :: Lens' DescribeAttachmentResponse Int
darStatus = lens _darStatus (\ s a -> s{_darStatus = a});
