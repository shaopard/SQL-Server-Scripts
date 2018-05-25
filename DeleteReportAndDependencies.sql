DECLARE @ReportID INT;
DECLARE @ReportQueryIDs TABLE (ID INT);
DECLARE @ReportQueryParameterIDs TABLE (ID INT);

-- The name of the report. Replace the string with any existing report name
DECLARE @ReportName VARCHAR(50) = 'OrderHistoryComparison';

-- Initialize the Report's related entities
SELECT @ReportID = ID FROM [Report] WHERE [Name] = @ReportName;
INSERT INTO @ReportQueryIDs SELECT ID FROM [ReportQuery] WHERE [ReportID] = @ReportID;
INSERT INTO @ReportQueryParameterIDs SELECT ID FROM [ReportQueryParameter] WHERE [ReportQueryID] IN (SELECT ID FROM @ReportQueryIDs);

-- DELETE dependencies
DELETE FROM [ReportQueryDependentParameter] 
WHERE [ReportQueryParameterID] IN (SELECT ID FROM @ReportQueryParameterIDs)
OR [ReportQueryParameterParentID] IN (SELECT ID FROM @ReportQueryParameterIDs);

-- DELETE query parameters
DELETE FROM [ReportQueryParameter] WHERE [ReportQueryID] IN (SELECT ID FROM @ReportQueryIDs);

-- DELETE report queries and report
DELETE FROM [ReportQuery] WHERE [ID] IN (SELECT ID FROM @ReportQueryIDs);
DELETE FROM [Report] WHERE [ID] = @ReportID;