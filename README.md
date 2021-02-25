# F5_BigIP_Orphaned_objects
List F5 BigIP configuration objects that are not in use.

This will, with time, be a series of bash scripts that detect various orhpaned objects.  The objects can be pools, monitors, profiles or Certificates.

We start with the orphan pool detector.  It lists the pools that are not being used by any virtual servers.  If a pool is used by an iRule, it may still be marked as orphaned in this initial version.

The Orphan monitor detector script, orph-monitors.sh, finds monitor names that are not referenced in pool properties.  This detector script ignores any of the system built-in monitors.


