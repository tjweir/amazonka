{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TypeFamilies      #-}

-- Module      : Network.AWS.Kinesis.MergeShards
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

-- | Merges two adjacent shards in a stream and combines them into a single
-- shard to reduce the stream\'s capacity to ingest and transport data. Two
-- shards are considered adjacent if the union of the hash key ranges for
-- the two shards form a contiguous set with no gaps. For example, if you
-- have two shards, one with a hash key range of 276...381 and the other
-- with a hash key range of 382...454, then you could merge these two
-- shards into a single shard that would have a hash key range of
-- 276...454. After the merge, the single child shard receives data for all
-- hash key values covered by the two parent shards.
--
-- @MergeShards@ is called when there is a need to reduce the overall
-- capacity of a stream because of excess capacity that is not being used.
-- You must specify the shard to be merged and the adjacent shard for a
-- stream. For more information about merging shards, see
-- <http://docs.aws.amazon.com/kinesis/latest/dev/kinesis-using-sdk-java-resharding-merge.html Merge Two Shards>
-- in the /Amazon Kinesis Developer Guide/.
--
-- If the stream is in the @ACTIVE@ state, you can call @MergeShards@. If a
-- stream is in the @CREATING@, @UPDATING@, or @DELETING@ state,
-- @MergeShards@ returns a @ResourceInUseException@. If the specified
-- stream does not exist, @MergeShards@ returns a
-- @ResourceNotFoundException@.
--
-- You can use DescribeStream to check the state of the stream, which is
-- returned in @StreamStatus@.
--
-- @MergeShards@ is an asynchronous operation. Upon receiving a
-- @MergeShards@ request, Amazon Kinesis immediately returns a response and
-- sets the @StreamStatus@ to @UPDATING@. After the operation is completed,
-- Amazon Kinesis sets the @StreamStatus@ to @ACTIVE@. Read and write
-- operations continue to work while the stream is in the @UPDATING@ state.
--
-- You use DescribeStream to determine the shard IDs that are specified in
-- the @MergeShards@ request.
--
-- If you try to operate on too many streams in parallel using
-- CreateStream, DeleteStream, @MergeShards@ or SplitShard, you will
-- receive a @LimitExceededException@.
--
-- @MergeShards@ has limit of 5 transactions per second per account.
--
-- <http://docs.aws.amazon.com/kinesis/latest/APIReference/API_MergeShards.html>
module Network.AWS.Kinesis.MergeShards
    (
    -- * Request
      MergeShards
    -- ** Request constructor
    , mergeShards
    -- ** Request lenses
    , msStreamName
    , msShardToMerge
    , msAdjacentShardToMerge

    -- * Response
    , MergeShardsResponse
    -- ** Response constructor
    , mergeShardsResponse
    ) where

import           Network.AWS.Kinesis.Types
import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response

-- | Represents the input for @MergeShards@.
--
-- /See:/ 'mergeShards' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'msStreamName'
--
-- * 'msShardToMerge'
--
-- * 'msAdjacentShardToMerge'
data MergeShards = MergeShards'
    { _msStreamName           :: Text
    , _msShardToMerge         :: Text
    , _msAdjacentShardToMerge :: Text
    } deriving (Eq,Read,Show)

-- | 'MergeShards' smart constructor.
mergeShards :: Text -> Text -> Text -> MergeShards
mergeShards pStreamName pShardToMerge pAdjacentShardToMerge =
    MergeShards'
    { _msStreamName = pStreamName
    , _msShardToMerge = pShardToMerge
    , _msAdjacentShardToMerge = pAdjacentShardToMerge
    }

-- | The name of the stream for the merge.
msStreamName :: Lens' MergeShards Text
msStreamName = lens _msStreamName (\ s a -> s{_msStreamName = a});

-- | The shard ID of the shard to combine with the adjacent shard for the
-- merge.
msShardToMerge :: Lens' MergeShards Text
msShardToMerge = lens _msShardToMerge (\ s a -> s{_msShardToMerge = a});

-- | The shard ID of the adjacent shard for the merge.
msAdjacentShardToMerge :: Lens' MergeShards Text
msAdjacentShardToMerge = lens _msAdjacentShardToMerge (\ s a -> s{_msAdjacentShardToMerge = a});

instance AWSRequest MergeShards where
        type Sv MergeShards = Kinesis
        type Rs MergeShards = MergeShardsResponse
        request = postJSON
        response = receiveNull MergeShardsResponse'

instance ToHeaders MergeShards where
        toHeaders
          = const
              (mconcat
                 ["X-Amz-Target" =#
                    ("Kinesis_20131202.MergeShards" :: ByteString),
                  "Content-Type" =#
                    ("application/x-amz-json-1.1" :: ByteString)])

instance ToJSON MergeShards where
        toJSON MergeShards'{..}
          = object
              ["StreamName" .= _msStreamName,
               "ShardToMerge" .= _msShardToMerge,
               "AdjacentShardToMerge" .= _msAdjacentShardToMerge]

instance ToPath MergeShards where
        toPath = const "/"

instance ToQuery MergeShards where
        toQuery = const mempty

-- | /See:/ 'mergeShardsResponse' smart constructor.
data MergeShardsResponse =
    MergeShardsResponse'
    deriving (Eq,Read,Show)

-- | 'MergeShardsResponse' smart constructor.
mergeShardsResponse :: MergeShardsResponse
mergeShardsResponse = MergeShardsResponse'
