class BooruImageIntensities {
  final double ne;
  final double nw;
  final double se;
  final double sw;

  BooruImageIntensities(this.ne, this.nw, this.se, this.sw);
}

class BooruImageRepresentation {
  final String full;
  final String large;
  final String medium;
  final String small;
  final String tall;
  final String thumb;
  final String thumbSmall;
  final String thumbTiny;

  BooruImageRepresentation(this.full, this.large, this.medium, this.small,
      this.tall, this.thumb, this.thumbSmall, this.thumbTiny);
}

class BooruImage {
  /// Whether the image is animated.
  final bool animated;

  /// The image's width divided by its height.
  final double aspectRatio;

  /// The image's width divided by its height.
  final int commentCount;

  /// The creation time, in UTC, of the image.
  final DateTime createdAt;

  /// The hide reason for the image, or null if none provided. This will only
  /// have a value on images which are deleted for a rule violation.
  final String? deletionReason;

  /// The image's description.
  final String description;

  /// The number of downvotes the image has.
  final int downvotes;

  /// The ID of the target image, or null if none provided. This will only have
  /// a value on images which are merged into another image.
  final int? duplicateOf;

  /// The number of seconds the image lasts, if animated, otherwise .04.
  final double duration;

  /// The number of faves the image has.
  final int faves;

  /// The time, in UTC, the image was first seen (before any duplicate merging).
  final String firstSeenAt;

  /// The file extension of the image. One of "gif", "jpg", "jpeg", "png",
  /// "svg", "webm".
  final String format;

  /// The image's height, in pixels.
  final int height;

  /// Whether the image is hidden. An image is hidden if it is merged or deleted
  /// for a rule violation.
  final bool hiddenFromUsers;

  /// The image's ID.
  final int id;

  /// Optional object of internal image intensity data for deduplication
  /// purposes. May be null if intensities have not yet been generated.
  final BooruImageIntensities? intensities;

  /// The MIME type of this image. One of "image/gif", "image/jpeg",
  /// "image/png", "image/svg+xml", "video/webm".
  final String mimeType;

  /// The filename that the image was uploaded with.
  final String name;

  /// The SHA512 hash of the image as it was originally uploaded.
  final String origSha512Hash;

  /// Whether the image has finished optimization.
  final bool processed;

  /// A mapping of representation names to their respective URLs. Contains the
  /// keys "full", "large", "medium", "small", "tall", "thumb", "thumb_small",
  /// "thumb_tiny".
  final BooruImageRepresentation representations;

  /// The image's number of upvotes minus the image's number of downvotes.
  final int score;

  /// The SHA512 hash of this image after it has been processed.
  final String sha512Hash;

  /// The number of bytes the image's file contains.
  final int size;

  /// The current source URL of the image.
  final String sourceURL;

  /// Whether the image is hit by the current filter.
  final bool spoilered;

  /// The number of tags present on the image.
  final int tagCount;

  /// A list of tag IDs the image contains.
  final List<int> tagIds;

  /// A list of tag names the image contains.
  final List<String> tags;

  /// Whether the image has finished thumbnail generation. Do not attempt to
  /// load images from view_url or representations if this is false.
  final bool thumbnailsGenerated;

  /// The time, in UTC, the image was last updated.
  final DateTime updatedAt;

  /// The image's uploader.
  final String uploader;

  /// The ID of the image's uploader. null if uploaded anonymously.
  final int? uploaderId;

  /// The image's number of upvotes.
  final int upvotes;

  /// The image's view URL, including tags.
  final String viewURL;

  /// The image's width, in pixels.
  final int width;

  /// The lower bound of the Wilson score interval for the image, based on its
  /// upvotes and downvotes, given a z-score corresponding to a confidence of 
  /// 99.5%.
  final double wilsonScore;

  BooruImage(
      this.animated,
      this.aspectRatio,
      this.commentCount,
      this.deletionReason,
      this.createdAt,
      this.description,
      this.downvotes,
      this.duplicateOf,
      this.duration,
      this.faves,
      this.firstSeenAt,
      this.format,
      this.height,
      this.hiddenFromUsers,
      this.id,
      this.intensities,
      this.mimeType,
      this.name,
      this.origSha512Hash,
      this.processed,
      this.representations,
      this.score,
      this.sha512Hash,
      this.size,
      this.sourceURL,
      this.spoilered,
      this.tagCount,
      this.tagIds,
      this.tags,
      this.thumbnailsGenerated,
      this.updatedAt,
      this.uploader,
      this.uploaderId,
      this.upvotes,
      this.width,
      this.wilsonScore, this.viewURL);
}
