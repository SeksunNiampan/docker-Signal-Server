/**
 * Copyright (C) 2013 Open WhisperSystems
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package org.whispersystems.textsecuregcm.s3;

import com.amazonaws.AmazonClientException; //new
import com.amazonaws.AmazonServiceException; //new

import com.amazonaws.auth.AWSStaticCredentialsProvider; //new
import com.amazonaws.client.builder.AwsClientBuilder; //new
import com.amazonaws.ClientConfiguration; //new
import com.amazonaws.regions.Regions; //new
import com.amazonaws.regions.Region; //new
import com.amazonaws.services.s3.AmazonS3ClientBuilder;//new

import com.amazonaws.HttpMethod;
import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.S3ClientOptions;
import com.amazonaws.services.s3.model.GeneratePresignedUrlRequest;
import org.whispersystems.textsecuregcm.configuration.AttachmentsConfiguration;

import java.net.URL;
import java.util.Date;

public class UrlSigner {

  private static final long   DURATION = 60 * 60 * 1000;

  private final AWSCredentials credentials;
  private final String bucket;

  public UrlSigner(AttachmentsConfiguration config) {
    this.credentials = new BasicAWSCredentials(config.getAccessKey(), config.getAccessSecret());
    this.bucket      = config.getBucket();
  }

  public URL getPreSignedUrl(long attachmentId, HttpMethod method, boolean unaccelerated) {
    ClientConfiguration clientConfiguration = new ClientConfiguration();
    clientConfiguration.setSignerOverride("AWSS3V4SignerType");
    
    AmazonS3                    client  = new AmazonS3Client(credentials, clientConfiguration);
    Region usEast1 = Region.getRegion(Regions.US_EAST_1);
    client.setRegion(usEast1);
    client.setEndpoint("https://projectsignal.me:9000");

    final S3ClientOptions clientOptions = S3ClientOptions.builder().setPathStyleAccess(true).build();
    client.setS3ClientOptions(clientOptions);
    
    GeneratePresignedUrlRequest request = new GeneratePresignedUrlRequest(bucket, String.valueOf(attachmentId), method);

    request.setExpiration(new Date(System.currentTimeMillis() + DURATION));
    request.setContentType("application/octet-stream");

    return client.generatePresignedUrl(request);
  }

}
