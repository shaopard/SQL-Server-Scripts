
select TOP 5000 i.ID, i.rundate, p.Name as program, s.Name as station, cp.Name As advertiser,
				ocm.isci, sl.Logdate, sl.schedulerid, sl.houroftheday, sl.positioninthehour,
				sl.breaknumber, p.cdnprogram, p.id as programID, s.id As stationid

from Inventory i 
                            join ContractDetail cd   on i.ContractDetailID = cd.ID
                            join Program p   on cd.ProgramID = p.ID
                            join SchedulerOrderSpot sos  on i.SchedulerOrderSpotID = sos.ID
                            join SchedulerLog sl on  sl.ID = sos.SchedulerLogID
                            join  Scheduler sch on sl.SchedulerID = sch.ID
                            join OrderSpot os on sos.OrderSpotID = os.ID
                            join OrderDetailWeek odw on os.OrderDetailWeekID = odw.ID
                            join OrderDetail od on odw.OrderDetailID = od.ID
                            join OrderHeader oh on od.OrderHeaderID = oh.ID
                            join Company cp  on oh.AdvertiserID = cp.ID
                            join  OrderCopyMedia ocm on i.OrderCopyMediaID = ocm.ID
                            join Station s on cd.StationID = s.ID
                            join  SchedulerStatus sstat on sch.ID = sstat.SchedulerID

							--where i.RunDate >= 2016/06/27 --AND i.RunDate <= endDate
                                WHERE sl.BreakNumber IS NOT NULL 
                                AND p.Active = 1
                                AND sch.Active = 1
								AND s.name LIKE '%KARV%'
                                AND (programId = 0 OR p.ID = programId)
                                AND (stationId = 0 OR s.ID = stationId)
								--AND sstat.SchedulerStatusTypeID >= 6
								--AND cp.Name LIKE '%CNBC%'
								--GROUP BY p.Name
								ORDER BY i.rundate ASC
                            
                            