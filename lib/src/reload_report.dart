// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

VMReloadReport newVMReloadReport(Map json) {
  if (json == null) return null;
  assert(json["type"] == "ReloadReport");
  return new VMReloadReport._(json);
}

/// The reload report that is returned by `VMIsolateRef.reloadSources`.
class VMReloadReport {
  static String extractMessage(Map json) {
    dynamic entry = json["details"];
    if (entry is Map) {
      entry = entry["notices"];
      if (entry is List) {
        // TODO: collect messages?
        entry = entry[0];
        if (entry is Map) {
          return entry["message"];
        }
      }
    }
    return null;
  }
  /// Did the reload succeed or fail?
  final bool status;
  // Failure message or null.
  final String message;

  VMReloadReport._(Map json) : status = json["success"], message = extractMessage(json);

  String toString() => "$status ($message)";
}