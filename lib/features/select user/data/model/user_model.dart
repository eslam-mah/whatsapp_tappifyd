import 'package:flutter/material.dart';

/// A model class representing a user in the chat application.
@immutable
class UserModel {
  /// The file of the user's profile image.
  ///
  /// This should be a valid URL string pointing to an image file.
  final String image;

  /// The name of the user.
  ///
  /// This is a string representing the user's display name.
  final String name;

  /// The unique identifier of the user.
  ///
  /// This is a string representing a unique ID assigned to the user.
  final String id;

  /// Creates a new instance of the [UserModel] class.
  ///
  /// The [image], [name], and [id] parameters are required and must not be null.
  const UserModel({
    required this.image,
    required this.name,
    required this.id,
  });
}
