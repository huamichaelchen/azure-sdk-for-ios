// --------------------------------------------------------------------------
//
// Copyright (c) Microsoft Corporation. All rights reserved.
//
// The MIT License (MIT)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the ""Software""), to
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED *AS IS*, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.
//
// --------------------------------------------------------------------------

import AzureCore
import Foundation

/// User-configurable options for the `StorageBlobClient.listContainers` operation.
public struct ListContainersOptions: AzureOptions {
    /// Datasets which may be included as part of the call response.
    public enum ListContainersInclude: String {
        /// Include the containers' metadata in the response.
        case metadata
    }

    /// A client-generated, opaque value with 1KB character limit that is recorded in analytics logs.
    public let clientRequestId: String?

    /// Return only containers whose names begin with the specified prefix.
    public let prefix: String?

    /// One or more datasets to include in the response.
    public let include: [ListContainersInclude]?

    /// Maximum number of containers to return, up to 5000.
    public let maxResults: Int?

    /// Request timeout in seconds.
    public let timeoutInSeconds: Int?

    /// Initialize a `ListContainersOptions` structure.
    /// - Parameters:
    ///   - clientRequestId: A client-generated, opaque value with 1KB character limit that is recorded in analytics
    ///     logs.
    ///   - prefix: Return only containers whose names begin with the specified prefix.
    ///   - include: One or more datasets to include in the response.
    ///   - maxResults: Maximum number of containers to return, up to 5000.
    ///   - timeoutInSeconds: Request timeout in seconds.
    public init(
        clientRequestId: String? = nil,
        prefix: String? = nil,
        include: [ListContainersInclude]? = nil,
        maxResults: Int? = nil,
        timeoutInSeconds: Int? = nil
    ) {
        self.clientRequestId = clientRequestId
        self.prefix = prefix
        self.include = include
        self.maxResults = maxResults
        self.timeoutInSeconds = timeoutInSeconds
    }
}

/// User-configurable options for the `StorageBlobClient.listBlobs` operation.
public struct ListBlobsOptions: AzureOptions {
    /// Datasets which may be included as part of the call response.
    public enum ListBlobsInclude: String {
        /// Include blob snapshots in the response.
        case snapshots
        /// Include the blobs' metadata in the response.
        case metadata
        /// Include blobs for which blocks have been uploaded, but which have not been committed, in the response.
        case uncommittedblobs
        /// Include metadata related to any current or previous Copy Blob operation in the response.
        case copy
        /// Include soft-deleted blobs in the response.
        case deleted
    }

    /// A client-generated, opaque value with 1KB character limit that is recorded in analytics logs.
    public let clientRequestId: String?

    /// Return only blobs whose names begin with the specified prefix.
    public let prefix: String?

    /// Operation returns a BlobPrefix element in the response body that acts as a placeholder for all
    /// blobs whose names begin with the same substring up to the appearance of the delimiter character.
    /// The delimiter may be a single charcter or a string.
    public let delimiter: String?

    /// Maximum number of containers to return, up to 5000.
    public let maxResults: Int?

    /// One or more datasets to include in the response.
    public let include: [ListBlobsInclude]?

    /// Request timeout in seconds.
    public let timeoutInSeconds: Int?

    /// Initialize a `ListBlobsOptions` structure.
    /// - Parameters:
    ///   - clientRequestId: A client-generated, opaque value with 1KB character limit that is recorded in analytics
    ///     logs.
    ///   - prefix: Return only blobs whose names begin with the specified prefix.
    ///   - delimiter: Operation returns a BlobPrefix element in the response body that acts as a placeholder for all
    ///     blobs whose names begin with the same substring up to the appearance of the delimiter character. The
    ///     delimiter may be a single charcter or a string.
    ///   - maxResults: Maximum number of containers to return, up to 5000.
    ///   - include: One or more datasets to include in the response.
    ///   - timeoutInSeconds: Request timeout in seconds.
    public init(
        clientRequestId: String? = nil,
        prefix: String? = nil,
        delimiter: String? = nil,
        maxResults: Int? = nil,
        include: [ListBlobsInclude]? = nil,
        timeoutInSeconds: Int? = nil
    ) {
        self.clientRequestId = clientRequestId
        self.prefix = prefix
        self.delimiter = delimiter
        self.maxResults = maxResults
        self.include = include
        self.timeoutInSeconds = timeoutInSeconds
    }
}

/// User-configurable options for the `StorageBlobClient.delete` operation.
public struct DeleteBlobOptions: AzureOptions {
    /// This header should be specified only for a request against the base blob resource.
    /// If this header is specified on a request to delete an individual snapshot, the Blob
    /// service returns status code 400 (Bad Request).
    /// If this header is not specified on the request and the blob has associated snapshots,
    /// the Blob service returns status code 409 (Conflict).
    public enum DeleteBlobSnapshot: String {
        /// Delete the base blob and all of its snapshots.
        case include
        /// Delete only the blob's snapshots and not the blob itself.
        case only
    }

    /// A client-generated, opaque value with 1KB character limit that is recorded in analytics logs.
    public let clientRequestId: String?

    /// Specify how blob snapshots should be handled. Required if the blob has associated snapshots.
    public let deleteSnapshots: DeleteBlobSnapshot?

    /// A `Date` specifying the snapshot you wish to delete.
    public let snapshot: Date?

    /// Request timeout in seconds.
    public let timeoutInSeconds: Int?

    /// Initialize a DeleteBlobOptions` structure.
    /// - Parameters:
    ///   - clientRequestId: A client-generated, opaque value with 1KB character limit that is recorded in analytics
    ///     logs.
    ///   - deleteSnapshots: `DeleteBlobSnapshot` value to specify how snapshots should be handled.
    ///   - timeoutInSeconds: Request timeout in seconds.
    public init(
        clientRequestId: String? = nil,
        deleteSnapshots: DeleteBlobSnapshot? = nil,
        snapshot: Date? = nil,
        timeoutInSeconds: Int? = nil
    ) {
        self.clientRequestId = clientRequestId
        self.deleteSnapshots = deleteSnapshots
        self.snapshot = snapshot
        self.timeoutInSeconds = timeoutInSeconds
    }
}

/// User-configurable options for the `StorageBlobClient.download` and `StorageBlobClient.rawDownload` operations.
public struct DownloadBlobOptions: AzureOptions, Codable, Equatable {
    /// A client-generated, opaque value with 1KB character limit that is recorded in analytics logs.
    public let clientRequestId: String?

    /// Options for working on a subset of data for a blob.
    public let range: RangeOptions?

    /// Required if the blob has an active lease. If specified, download only
    /// succeeds if the blob's lease is active and matches this ID.
    public let leaseId: String?

    /// A snapshot version for the blob being downloaded.
    public let snapshot: String?

    /// Options for accessing a blob based on the condition of a lease. If specified, the operation will be performed
    /// only if both of the following conditions are met:
    /// - The blob's lease is currently active.
    /// - The specified lease ID matches that of the blob.
    public let leaseAccessConditions: LeaseAccessConditions?

    /// Options for accessing a blob based on its modification date and/or eTag. If specified, the operation will be
    /// performed only if all the specified conditions are met.
    public internal(set) var modifiedAccessConditions: ModifiedAccessConditions?

    /// Blob encryption options.
    public let encryptionOptions: EncryptionOptions?

    /// Encrypts the data on the service-side with the given key.
    /// Use of customer-provided keys must be done over HTTPS.
    /// As the encryption key itself is provided in the request,
    /// a secure connection must be established to transfer the key.
    public let customerProvidedEncryptionKey: CustomerProvidedEncryptionKey?

    /// Encoding with which to decode the downloaded bytes. If nil, no decoding occurs.
    public let encoding: String?

    /// The timeout parameter is expressed in seconds. This method may make
    /// multiple calls to the Azure service and the timeout will apply to
    /// each call individually.
    public let timeoutInSeconds: Int?

    /// Initialize a `DownloadBlobOptions` structure.
    /// - Parameters:
    ///   - clientRequestId: A client-generated, opaque value with 1KB character limit that is recorded in analytics
    ///     logs.
    ///   - destination: Options for overriding the default download destination behavior.
    ///   - range: Options for working on a subset of data for a blob.
    ///   - leaseId: Required if the blob has an active lease. If specified, download only succeeds if the blob's lease
    ///     is active and matches this ID.
    ///   - snapshot: A snapshot version for the blob being downloaded.
    ///   - leaseAccessConditions: Options for accessing a blob based on the condition of a lease. If specified, the
    ///     operation will be performed only if both of the following conditions are met:
    ///     - The blob's lease is currently active.
    ///     - The specified lease ID matches that of the blob.
    ///   - modifiedAccessConditions: Options for accessing a blob based on its modification date and/or eTag. If
    ///     specified, the operation will be performed only if all the specified conditions are met.
    ///   - encryptionOptions: Blob encryption options.
    ///   - customerProvidedEncryptionKey: Encrypts the data on the service-side with the given key. Use of
    ///     customer-provided keys must be done over HTTPS. As the encryption key itself is provided in the request, a
    ///     secure connection must be established to transfer the key.
    ///   - encoding: Encoding with which to decode the downloaded bytes. If nil, no decoding occurs.
    ///   - timeoutInSeconds: The timeout parameter is expressed in seconds. This method may make multiple calls to the
    ///     Azure service and the timeout will apply to each call individually.
    public init(
        clientRequestId: String? = nil,
        range: RangeOptions? = nil,
        leaseId: String? = nil,
        snapshot: String? = nil,
        leaseAccessConditions: LeaseAccessConditions? = nil,
        modifiedAccessConditions: ModifiedAccessConditions? = nil,
        encryptionOptions: EncryptionOptions? = nil,
        customerProvidedEncryptionKey: CustomerProvidedEncryptionKey? = nil,
        encoding: String? = nil,
        timeoutInSeconds: Int? = nil
    ) {
        self.clientRequestId = clientRequestId
        self.range = range
        self.leaseId = leaseId
        self.snapshot = snapshot
        self.leaseAccessConditions = leaseAccessConditions
        self.modifiedAccessConditions = modifiedAccessConditions
        self.encryptionOptions = encryptionOptions
        self.customerProvidedEncryptionKey = customerProvidedEncryptionKey
        self.encoding = encoding
        self.timeoutInSeconds = timeoutInSeconds
    }
}

/// User-configurable options for the `StorageBlobClient.upload` and `StorageBlobClient.rawUpload` operations.
public struct UploadBlobOptions: AzureOptions, Codable, Equatable {
    /// A client-generated, opaque value with 1KB character limit that is recorded in analytics logs.
    public let clientRequestId: String?

    /// Options for accessing a blob based on the condition of a lease. If specified, the operation will be performed
    /// only if both of the following conditions are met:
    /// - The blob's lease is currently active.
    /// - The specified lease ID matches that of the blob.
    public let leaseAccessConditions: LeaseAccessConditions?

    /// Options for accessing a blob based on its modification date and/or eTag. If specified, the operation will be
    /// performed only if all the specified conditions are met.
    public let modifiedAccessConditions: ModifiedAccessConditions?

    /// Blob encryption options.
    public let encryptionOptions: EncryptionOptions?

    /// Encrypts the data on the service-side with the given key.
    /// Use of customer-provided keys must be done over HTTPS.
    /// As the encryption key itself is provided in the request,
    /// a secure connection must be established to transfer the key.
    public let customerProvidedEncryptionKey: CustomerProvidedEncryptionKey?

    /// The name of the predefined encryption scope used to encrypt the blob contents and metadata. Note that omitting
    /// this value implies use of the default account encryption scope.
    public let customerProvidedEncryptionScope: String?

    /// Encoding with which to encode the uploaded bytes. If nil, no encoding occurs.
    public let encoding: String?

    /// The timeout parameter is expressed in seconds. This method may make
    /// multiple calls to the Azure service and the timeout will apply to
    /// each call individually.
    public let timeoutInSeconds: Int?

    /// Initialize an `UploadBlobOptions` structure.
    /// - Parameters:
    ///   - clientRequestId: A client-generated, opaque value with 1KB character limit that is recorded in analytics
    ///     logs.
    ///   - leaseAccessConditions: Options for accessing a blob based on the condition of a lease. If specified, the
    ///     operation will be performed only if both of the following conditions are met:
    ///     - The blob's lease is currently active.
    ///     - The specified lease ID matches that of the blob.
    ///   - modifiedAccessConditions: Options for accessing a blob based on its modification date and/or eTag. If
    ///     specified, the operation will be performed only if all the specified conditions are met.
    ///   - encryptionOptions: Blob encryption options.
    ///   - customerProvidedEncryptionKey: Encrypts the data on the service-side with the given key. Use of
    ///     customer-provided keys must be done over HTTPS. As the encryption key itself is provided in the request, a
    ///     secure connection must be established to transfer the key.
    ///   - customerProvidedEncryptionScope: The name of the predefined encryption scope used to encrypt the blob
    ///   contents and metadata. Note that omitting this value implies use of the default account encryption scope.
    ///   - encoding: Encoding with which to decode the downloaded bytes. If nil, no decoding occurs.
    ///   - timeoutInSeconds: The timeout parameter is expressed in seconds. This method may make multiple calls to the
    ///     Azure service and the timeout will apply to each call individually.
    public init(
        clientRequestId: String? = nil,
        leaseAccessConditions: LeaseAccessConditions? = nil,
        modifiedAccessConditions: ModifiedAccessConditions? = nil,
        encryptionOptions: EncryptionOptions? = nil,
        customerProvidedEncryptionKey: CustomerProvidedEncryptionKey? = nil,
        customerProvidedEncryptionScope: String? = nil,
        encoding: String? = nil,
        timeoutInSeconds: Int? = nil
    ) {
        self.clientRequestId = clientRequestId
        self.leaseAccessConditions = leaseAccessConditions
        self.modifiedAccessConditions = modifiedAccessConditions
        self.encryptionOptions = encryptionOptions
        self.customerProvidedEncryptionKey = customerProvidedEncryptionKey
        self.customerProvidedEncryptionScope = customerProvidedEncryptionScope
        self.encoding = encoding
        self.timeoutInSeconds = timeoutInSeconds
    }
}
