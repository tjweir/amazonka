{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TypeFamilies      #-}

-- Module      : Network.AWS.StorageGateway.ListLocalDisks
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

-- | This operation returns a list of the gateway\'s local disks. To specify
-- which gateway to describe, you use the Amazon Resource Name (ARN) of the
-- gateway in the body of the request.
--
-- The request returns a list of all disks, specifying which are configured
-- as working storage, cache storage, or stored volume or not configured at
-- all. The response includes a @DiskStatus@ field. This field can have a
-- value of present (the disk is available to use), missing (the disk is no
-- longer connected to the gateway), or mismatch (the disk node is occupied
-- by a disk that has incorrect metadata or the disk content is corrupted).
--
-- <http://docs.aws.amazon.com/storagegateway/latest/APIReference/API_ListLocalDisks.html>
module Network.AWS.StorageGateway.ListLocalDisks
    (
    -- * Request
      ListLocalDisks
    -- ** Request constructor
    , listLocalDisks
    -- ** Request lenses
    , lldGatewayARN

    -- * Response
    , ListLocalDisksResponse
    -- ** Response constructor
    , listLocalDisksResponse
    -- ** Response lenses
    , lldrGatewayARN
    , lldrDisks
    , lldrStatus
    ) where

import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response
import           Network.AWS.StorageGateway.Types

-- | A JSON object containing the of the gateway.
--
-- /See:/ 'listLocalDisks' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'lldGatewayARN'
newtype ListLocalDisks = ListLocalDisks'
    { _lldGatewayARN :: Text
    } deriving (Eq,Read,Show)

-- | 'ListLocalDisks' smart constructor.
listLocalDisks :: Text -> ListLocalDisks
listLocalDisks pGatewayARN =
    ListLocalDisks'
    { _lldGatewayARN = pGatewayARN
    }

-- | FIXME: Undocumented member.
lldGatewayARN :: Lens' ListLocalDisks Text
lldGatewayARN = lens _lldGatewayARN (\ s a -> s{_lldGatewayARN = a});

instance AWSRequest ListLocalDisks where
        type Sv ListLocalDisks = StorageGateway
        type Rs ListLocalDisks = ListLocalDisksResponse
        request = postJSON
        response
          = receiveJSON
              (\ s h x ->
                 ListLocalDisksResponse' <$>
                   (x .?> "GatewayARN") <*> (x .?> "Disks" .!@ mempty)
                     <*> (pure (fromEnum s)))

instance ToHeaders ListLocalDisks where
        toHeaders
          = const
              (mconcat
                 ["X-Amz-Target" =#
                    ("StorageGateway_20130630.ListLocalDisks" ::
                       ByteString),
                  "Content-Type" =#
                    ("application/x-amz-json-1.1" :: ByteString)])

instance ToJSON ListLocalDisks where
        toJSON ListLocalDisks'{..}
          = object ["GatewayARN" .= _lldGatewayARN]

instance ToPath ListLocalDisks where
        toPath = const "/"

instance ToQuery ListLocalDisks where
        toQuery = const mempty

-- | /See:/ 'listLocalDisksResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'lldrGatewayARN'
--
-- * 'lldrDisks'
--
-- * 'lldrStatus'
data ListLocalDisksResponse = ListLocalDisksResponse'
    { _lldrGatewayARN :: Maybe Text
    , _lldrDisks      :: Maybe [Disk]
    , _lldrStatus     :: !Int
    } deriving (Eq,Read,Show)

-- | 'ListLocalDisksResponse' smart constructor.
listLocalDisksResponse :: Int -> ListLocalDisksResponse
listLocalDisksResponse pStatus =
    ListLocalDisksResponse'
    { _lldrGatewayARN = Nothing
    , _lldrDisks = Nothing
    , _lldrStatus = pStatus
    }

-- | FIXME: Undocumented member.
lldrGatewayARN :: Lens' ListLocalDisksResponse (Maybe Text)
lldrGatewayARN = lens _lldrGatewayARN (\ s a -> s{_lldrGatewayARN = a});

-- | FIXME: Undocumented member.
lldrDisks :: Lens' ListLocalDisksResponse [Disk]
lldrDisks = lens _lldrDisks (\ s a -> s{_lldrDisks = a}) . _Default;

-- | FIXME: Undocumented member.
lldrStatus :: Lens' ListLocalDisksResponse Int
lldrStatus = lens _lldrStatus (\ s a -> s{_lldrStatus = a});
