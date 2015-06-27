{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TypeFamilies      #-}

-- Module      : Network.AWS.CloudHSM.ListHAPGs
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

-- | Lists the high-availability partition groups for the account.
--
-- This operation supports pagination with the use of the /NextToken/
-- member. If more results are available, the /NextToken/ member of the
-- response contains a token that you pass in the next call to ListHapgs to
-- retrieve the next set of items.
--
-- <http://docs.aws.amazon.com/cloudhsm/latest/dg/API_ListHAPGs.html>
module Network.AWS.CloudHSM.ListHAPGs
    (
    -- * Request
      ListHAPGs
    -- ** Request constructor
    , listHAPGs
    -- ** Request lenses
    , lhNextToken

    -- * Response
    , ListHAPGsResponse
    -- ** Response constructor
    , listHAPGsResponse
    -- ** Response lenses
    , lhrNextToken
    , lhrHAPGList
    , lhrStatus
    ) where

import           Network.AWS.CloudHSM.Types
import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response

-- | /See:/ 'listHAPGs' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'lhNextToken'
newtype ListHAPGs = ListHAPGs'
    { _lhNextToken :: Maybe Text
    } deriving (Eq,Read,Show)

-- | 'ListHAPGs' smart constructor.
listHAPGs :: ListHAPGs
listHAPGs =
    ListHAPGs'
    { _lhNextToken = Nothing
    }

-- | The /NextToken/ value from a previous call to ListHapgs. Pass null if
-- this is the first call.
lhNextToken :: Lens' ListHAPGs (Maybe Text)
lhNextToken = lens _lhNextToken (\ s a -> s{_lhNextToken = a});

instance AWSRequest ListHAPGs where
        type Sv ListHAPGs = CloudHSM
        type Rs ListHAPGs = ListHAPGsResponse
        request = postJSON
        response
          = receiveJSON
              (\ s h x ->
                 ListHAPGsResponse' <$>
                   (x .?> "NextToken") <*> (x .?> "HapgList" .!@ mempty)
                     <*> (pure (fromEnum s)))

instance ToHeaders ListHAPGs where
        toHeaders
          = const
              (mconcat
                 ["X-Amz-Target" =#
                    ("CloudHsmFrontendService.ListHAPGs" :: ByteString),
                  "Content-Type" =#
                    ("application/x-amz-json-1.1" :: ByteString)])

instance ToJSON ListHAPGs where
        toJSON ListHAPGs'{..}
          = object ["NextToken" .= _lhNextToken]

instance ToPath ListHAPGs where
        toPath = const "/"

instance ToQuery ListHAPGs where
        toQuery = const mempty

-- | /See:/ 'listHAPGsResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'lhrNextToken'
--
-- * 'lhrHAPGList'
--
-- * 'lhrStatus'
data ListHAPGsResponse = ListHAPGsResponse'
    { _lhrNextToken :: Maybe Text
    , _lhrHAPGList  :: [Text]
    , _lhrStatus    :: !Int
    } deriving (Eq,Read,Show)

-- | 'ListHAPGsResponse' smart constructor.
listHAPGsResponse :: Int -> ListHAPGsResponse
listHAPGsResponse pStatus =
    ListHAPGsResponse'
    { _lhrNextToken = Nothing
    , _lhrHAPGList = mempty
    , _lhrStatus = pStatus
    }

-- | If not null, more results are available. Pass this value to ListHapgs to
-- retrieve the next set of items.
lhrNextToken :: Lens' ListHAPGsResponse (Maybe Text)
lhrNextToken = lens _lhrNextToken (\ s a -> s{_lhrNextToken = a});

-- | The list of high-availability partition groups.
lhrHAPGList :: Lens' ListHAPGsResponse [Text]
lhrHAPGList = lens _lhrHAPGList (\ s a -> s{_lhrHAPGList = a});

-- | FIXME: Undocumented member.
lhrStatus :: Lens' ListHAPGsResponse Int
lhrStatus = lens _lhrStatus (\ s a -> s{_lhrStatus = a});
