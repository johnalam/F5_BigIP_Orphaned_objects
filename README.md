# F5_BigIP_Orphened_objects
List F5 BigIP configuration objects that are not in use.

This will, with time, be a series of bash scripts that detect various orhpened objects.  The objects can be pools, monitors, profiles or Certificates.

We start with the pool detector.  It lists the pools that are not being used by any virtual servers.  If a pool is used by an iRule, it may still be marked as orphened in this initial version.
