{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TypeFamilies      #-}

-- Module      : Network.AWS.ElasticTranscoder.ListJobsByPipeline
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

-- | The ListJobsByPipeline operation gets a list of the jobs currently in a
-- pipeline.
--
-- Elastic Transcoder returns all of the jobs currently in the specified
-- pipeline. The response body contains one element for each job that
-- satisfies the search criteria.
--
-- <http://docs.aws.amazon.com/elastictranscoder/latest/developerguide/ListJobsByPipeline.html>
module Network.AWS.ElasticTranscoder.ListJobsByPipeline
    (
    -- * Request
      ListJobsByPipeline
    -- ** Request constructor
    , listJobsByPipeline
    -- ** Request lenses
    , ljbpAscending
    , ljbpPageToken
    , ljbpPipelineId

    -- * Response
    , ListJobsByPipelineResponse
    -- ** Response constructor
    , listJobsByPipelineResponse
    -- ** Response lenses
    , ljbprNextPageToken
    , ljbprJobs
    , ljbprStatus
    ) where

import           Network.AWS.ElasticTranscoder.Types
import           Network.AWS.Pager
import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response

-- | The @ListJobsByPipelineRequest@ structure.
--
-- /See:/ 'listJobsByPipeline' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'ljbpAscending'
--
-- * 'ljbpPageToken'
--
-- * 'ljbpPipelineId'
data ListJobsByPipeline = ListJobsByPipeline'
    { _ljbpAscending  :: Maybe Text
    , _ljbpPageToken  :: Maybe Text
    , _ljbpPipelineId :: Text
    } deriving (Eq,Read,Show)

-- | 'ListJobsByPipeline' smart constructor.
listJobsByPipeline :: Text -> ListJobsByPipeline
listJobsByPipeline pPipelineId =
    ListJobsByPipeline'
    { _ljbpAscending = Nothing
    , _ljbpPageToken = Nothing
    , _ljbpPipelineId = pPipelineId
    }

-- | To list jobs in chronological order by the date and time that they were
-- submitted, enter @true@. To list jobs in reverse chronological order,
-- enter @false@.
ljbpAscending :: Lens' ListJobsByPipeline (Maybe Text)
ljbpAscending = lens _ljbpAscending (\ s a -> s{_ljbpAscending = a});

-- | When Elastic Transcoder returns more than one page of results, use
-- @pageToken@ in subsequent @GET@ requests to get each successive page of
-- results.
ljbpPageToken :: Lens' ListJobsByPipeline (Maybe Text)
ljbpPageToken = lens _ljbpPageToken (\ s a -> s{_ljbpPageToken = a});

-- | The ID of the pipeline for which you want to get job information.
ljbpPipelineId :: Lens' ListJobsByPipeline Text
ljbpPipelineId = lens _ljbpPipelineId (\ s a -> s{_ljbpPipelineId = a});

instance AWSPager ListJobsByPipeline where
        page rq rs
          | stop (rs ^. ljbprNextPageToken) = Nothing
          | stop (rs ^. ljbprJobs) = Nothing
          | otherwise =
            Just $ rq & ljbpPageToken .~ rs ^. ljbprNextPageToken

instance AWSRequest ListJobsByPipeline where
        type Sv ListJobsByPipeline = ElasticTranscoder
        type Rs ListJobsByPipeline =
             ListJobsByPipelineResponse
        request = get
        response
          = receiveJSON
              (\ s h x ->
                 ListJobsByPipelineResponse' <$>
                   (x .?> "NextPageToken") <*> (x .?> "Jobs" .!@ mempty)
                     <*> (pure (fromEnum s)))

instance ToHeaders ListJobsByPipeline where
        toHeaders = const mempty

instance ToPath ListJobsByPipeline where
        toPath ListJobsByPipeline'{..}
          = mconcat
              ["/2012-09-25/jobsByPipeline/",
               toText _ljbpPipelineId]

instance ToQuery ListJobsByPipeline where
        toQuery ListJobsByPipeline'{..}
          = mconcat
              ["Ascending" =: _ljbpAscending,
               "PageToken" =: _ljbpPageToken]

-- | The @ListJobsByPipelineResponse@ structure.
--
-- /See:/ 'listJobsByPipelineResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'ljbprNextPageToken'
--
-- * 'ljbprJobs'
--
-- * 'ljbprStatus'
data ListJobsByPipelineResponse = ListJobsByPipelineResponse'
    { _ljbprNextPageToken :: Maybe Text
    , _ljbprJobs          :: Maybe [Job']
    , _ljbprStatus        :: !Int
    } deriving (Eq,Read,Show)

-- | 'ListJobsByPipelineResponse' smart constructor.
listJobsByPipelineResponse :: Int -> ListJobsByPipelineResponse
listJobsByPipelineResponse pStatus =
    ListJobsByPipelineResponse'
    { _ljbprNextPageToken = Nothing
    , _ljbprJobs = Nothing
    , _ljbprStatus = pStatus
    }

-- | A value that you use to access the second and subsequent pages of
-- results, if any. When the jobs in the specified pipeline fit on one page
-- or when you\'ve reached the last page of results, the value of
-- @NextPageToken@ is @null@.
ljbprNextPageToken :: Lens' ListJobsByPipelineResponse (Maybe Text)
ljbprNextPageToken = lens _ljbprNextPageToken (\ s a -> s{_ljbprNextPageToken = a});

-- | An array of @Job@ objects that are in the specified pipeline.
ljbprJobs :: Lens' ListJobsByPipelineResponse [Job']
ljbprJobs = lens _ljbprJobs (\ s a -> s{_ljbprJobs = a}) . _Default;

-- | FIXME: Undocumented member.
ljbprStatus :: Lens' ListJobsByPipelineResponse Int
ljbprStatus = lens _ljbprStatus (\ s a -> s{_ljbprStatus = a});
