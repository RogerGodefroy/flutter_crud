// Mocks generated by Mockito 5.4.4 from annotations
// in cbs_notes_crud/test/bloc/note_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:cbs_notes_crud/helpers/db_helper.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite/sqflite.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeDatabase_0 extends _i1.SmartFake implements _i2.Database {
  _FakeDatabase_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [DBHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDBHelper extends _i1.Mock implements _i3.DBHelper {
  MockDBHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Database> get database => (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: _i4.Future<_i2.Database>.value(_FakeDatabase_0(
          this,
          Invocation.getter(#database),
        )),
      ) as _i4.Future<_i2.Database>);

  @override
  void setDbPath(String? dbPath) => super.noSuchMethod(
        Invocation.method(
          #setDbPath,
          [dbPath],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i4.Future<int> create(Map<String, dynamic>? note) => (super.noSuchMethod(
        Invocation.method(
          #create,
          [note],
        ),
        returnValue: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);

  @override
  _i4.Future<List<Map<String, dynamic>>> readAllNotes() => (super.noSuchMethod(
        Invocation.method(
          #readAllNotes,
          [],
        ),
        returnValue: _i4.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i4.Future<List<Map<String, dynamic>>>);

  @override
  _i4.Future<int> update(Map<String, dynamic>? note) => (super.noSuchMethod(
        Invocation.method(
          #update,
          [note],
        ),
        returnValue: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);

  @override
  _i4.Future<int> delete(int? id) => (super.noSuchMethod(
        Invocation.method(
          #delete,
          [id],
        ),
        returnValue: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);

  @override
  _i4.Future<dynamic> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i4.Future<dynamic>.value(),
      ) as _i4.Future<dynamic>);
}