{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TypeFamilies      #-}

-- Module      : Network.AWS.WorkSpaces.TerminateWorkspaces
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

-- | Terminates the specified WorkSpaces.
--
-- Terminating a WorkSpace is a permanent action and cannot be undone. The
-- user\'s data is not maintained and will be destroyed. If you need to
-- archive any user data, contact Amazon Web Services before terminating
-- the WorkSpace.
--
-- You can terminate a WorkSpace that is in any state except @SUSPENDED@.
--
-- This operation is asynchronous and will return before the WorkSpaces
-- have been completely terminated.
--
-- <http://docs.aws.amazon.com/workspaces/latest/devguide/API_TerminateWorkspaces.html>
module Network.AWS.WorkSpaces.TerminateWorkspaces
    (
    -- * Request
      TerminateWorkspaces
    -- ** Request constructor
    , terminateWorkspaces
    -- ** Request lenses
    , twTerminateWorkspaceRequests

    -- * Response
    , TerminateWorkspacesResponse
    -- ** Response constructor
    , terminateWorkspacesResponse
    -- ** Response lenses
    , twrFailedRequests
    , twrStatus
    ) where

import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response
import           Network.AWS.WorkSpaces.Types

-- | Contains the inputs for the TerminateWorkspaces operation.
--
-- /See:/ 'terminateWorkspaces' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'twTerminateWorkspaceRequests'
newtype TerminateWorkspaces = TerminateWorkspaces'
    { _twTerminateWorkspaceRequests :: List1 TerminateRequest
    } deriving (Eq,Read,Show)

-- | 'TerminateWorkspaces' smart constructor.
terminateWorkspaces :: NonEmpty TerminateRequest -> TerminateWorkspaces
terminateWorkspaces pTerminateWorkspaceRequests =
    TerminateWorkspaces'
    { _twTerminateWorkspaceRequests = _List1 # pTerminateWorkspaceRequests
    }

-- | An array of structures that specify the WorkSpaces to terminate.
twTerminateWorkspaceRequests :: Lens' TerminateWorkspaces (NonEmpty TerminateRequest)
twTerminateWorkspaceRequests = lens _twTerminateWorkspaceRequests (\ s a -> s{_twTerminateWorkspaceRequests = a}) . _List1;

instance AWSRequest TerminateWorkspaces where
        type Sv TerminateWorkspaces = WorkSpaces
        type Rs TerminateWorkspaces =
             TerminateWorkspacesResponse
        request = postJSON
        response
          = receiveJSON
              (\ s h x ->
                 TerminateWorkspacesResponse' <$>
                   (x .?> "FailedRequests" .!@ mempty) <*>
                     (pure (fromEnum s)))

instance ToHeaders TerminateWorkspaces where
        toHeaders
          = const
              (mconcat
                 ["X-Amz-Target" =#
                    ("WorkspacesService.TerminateWorkspaces" ::
                       ByteString),
                  "Content-Type" =#
                    ("application/x-amz-json-1.1" :: ByteString)])

instance ToJSON TerminateWorkspaces where
        toJSON TerminateWorkspaces'{..}
          = object
              ["TerminateWorkspaceRequests" .=
                 _twTerminateWorkspaceRequests]

instance ToPath TerminateWorkspaces where
        toPath = const "/"

instance ToQuery TerminateWorkspaces where
        toQuery = const mempty

-- | Contains the results of the TerminateWorkspaces operation.
--
-- /See:/ 'terminateWorkspacesResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'twrFailedRequests'
--
-- * 'twrStatus'
data TerminateWorkspacesResponse = TerminateWorkspacesResponse'
    { _twrFailedRequests :: Maybe [FailedWorkspaceChangeRequest]
    , _twrStatus         :: !Int
    } deriving (Eq,Read,Show)

-- | 'TerminateWorkspacesResponse' smart constructor.
terminateWorkspacesResponse :: Int -> TerminateWorkspacesResponse
terminateWorkspacesResponse pStatus =
    TerminateWorkspacesResponse'
    { _twrFailedRequests = Nothing
    , _twrStatus = pStatus
    }

-- | An array of structures that represent any WorkSpaces that could not be
-- terminated.
twrFailedRequests :: Lens' TerminateWorkspacesResponse [FailedWorkspaceChangeRequest]
twrFailedRequests = lens _twrFailedRequests (\ s a -> s{_twrFailedRequests = a}) . _Default;

-- | FIXME: Undocumented member.
twrStatus :: Lens' TerminateWorkspacesResponse Int
twrStatus = lens _twrStatus (\ s a -> s{_twrStatus = a});
