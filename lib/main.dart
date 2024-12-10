// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: avoid_print, unused_import

import 'package:auth_login/apple.dart';
import 'package:auth_login/google.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Sign In',
      home: SignInAppleId(),
    ),
  );
}
