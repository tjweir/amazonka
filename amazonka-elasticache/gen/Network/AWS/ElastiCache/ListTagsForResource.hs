{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TypeFamilies      #-}

-- Module      : Network.AWS.ElastiCache.ListTagsForResource
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

-- | The /ListTagsForResource/ action lists all cost allocation tags
-- currently on the named resource. A /cost allocation tag/ is a key-value
-- pair where the key is case-sensitive and the value is optional. Cost
-- allocation tags can be used to categorize and track your AWS costs.
--
-- You can have a maximum of 10 cost allocation tags on an ElastiCache
-- resource. For more information, see
-- <http://docs.aws.amazon.com/AmazonElastiCache/latest/UserGuide/BestPractices.html Using Cost Allocation Tags in Amazon ElastiCache>.
--
-- <http://docs.aws.amazon.com/AmazonElastiCache/latest/APIReference/API_ListTagsForResource.html>
module Network.AWS.ElastiCache.ListTagsForResource
    (
    -- * Request
      ListTagsForResource
    -- ** Request constructor
    , listTagsForResource
    -- ** Request lenses
    , ltfrResourceName

    -- * Response
    , TagListMessage
    -- ** Response constructor
    , tagListMessage
    -- ** Response lenses
    , tlmTagList
    ) where

import           Network.AWS.ElastiCache.Types
import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response

-- | The input parameters for the /ListTagsForResource/ action.
--
-- /See:/ 'listTagsForResource' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'ltfrResourceName'
newtype ListTagsForResource = ListTagsForResource'
    { _ltfrResourceName :: Text
    } deriving (Eq,Read,Show)

-- | 'ListTagsForResource' smart constructor.
listTagsForResource :: Text -> ListTagsForResource
listTagsForResource pResourceName =
    ListTagsForResource'
    { _ltfrResourceName = pResourceName
    }

-- | The name of the resource for which you want the list of tags, for
-- example @arn:aws:elasticache:us-west-2:0123456789:cluster:myCluster@.
ltfrResourceName :: Lens' ListTagsForResource Text
ltfrResourceName = lens _ltfrResourceName (\ s a -> s{_ltfrResourceName = a});

instance AWSRequest ListTagsForResource where
        type Sv ListTagsForResource = ElastiCache
        type Rs ListTagsForResource = TagListMessage
        request = post
        response
          = receiveXMLWrapper "ListTagsForResourceResult"
              (\ s h x -> parseXML x)

instance ToHeaders ListTagsForResource where
        toHeaders = const mempty

instance ToPath ListTagsForResource where
        toPath = const "/"

instance ToQuery ListTagsForResource where
        toQuery ListTagsForResource'{..}
          = mconcat
              ["Action" =: ("ListTagsForResource" :: ByteString),
               "Version" =: ("2015-02-02" :: ByteString),
               "ResourceName" =: _ltfrResourceName]
