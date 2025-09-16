# Video Streaming

## Mike Kilmer AWS USER
- 621014405518

## AWS

### Config
See the gitignored awsclicfg file and ensure there is a profile section in ~/.aws/config
with those credentials:

```
[profile elliptica]
aws_access_key_id = XXXXXX
aws_secret_access_key = XXXXXXX
```

Use it like `aws --profile elliptica s3 ls`

[good reference on yt](https://www.youtube.com/watch?v=JbVyTrfqshU)

- Elastic Transcoder replaced with MediaConvert
- Add to IAM role, MediaConvert
- Select CMAF: Create a fragmented MP4 ABR stack for streaming to both Apple HLS or MPEG-DASH compatible players.

- - Other options:
- - - File group Create unpackaged outputs, such as MPEG-4 or QuickTime files.
- - - Apple HLS Create a stack of outputs for adaptive bitrate streaming to Apple players.
- - - DASH ISO Create a stack of outputs for adaptive bitrate streaming to MPEG-DASH players.
- - - Microsoft Smooth StreamingPro Create a stack of outputs for adaptive bitrate streaming to Microsoft players.


- Two output subsettings for CMAF: AV1 and AAC. I left both with default settings.
- Output Preset I set to `System-Avc_16x9_270p_14_99fps_400kbps`
- Aspect Ratios: `1920x1080 and you set Height to 720, your output will be 1280x720`
- Bitrate: `16200` in this case
- CloudFront distro point: `arn:aws:cloudfront::621014405518:distribution/E2H37VGHU8AWQH`
- test distro single point: `arn:aws:cloudfront::621014405518:distribution/, http://d1qwx91jjpd4x0.cloudfront.net`
- a demo video: `https://d1qwx91jjpd4x0.cloudfront.net/10second1_h264.cmfv`
- [AWS repo example](https://github.com/aws-samples/aws-media-services-simple-vod-workflow/blob/master/7-MediaConvertJobLambda/README.md)
- [AWS Lambda](https://github.com/aws-samples/aws-media-services-simple-vod-workflow/blob/master/7-MediaConvertJobLambda/lambda.zip)
- [AWS Workshop archive](https://github.com/aws-samples/aws-media-services-simple-vod-workflow)
- [YT reference for above three archives](https://www.youtube.com/watch?v=t83t2CNTZyU)
- [One option for a js player](https://videojs.com)

### Access Policy

####  to access via web:
```
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "PublicReadGetObject",
			"Effect": "Allow",
			"Principal": "*",
			"Action": "s3:GetObject",
			"Resource": "arn:aws:s3:::ellipticaoutputvideos/*"
		}
	]
}
```

#### VODLambdaRole Trusted Relationships needs to have two policies:

```
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Effect": "Allow",
			"Sid": "",
			"Principal": {
				"Service": "lambda.amazonaws.com"
			},
			"Action": "sts:AssumeRole"
		},
		{
			"Sid": "Statement1",
			"Effect": "Allow",
			"Principal": {
			    "Service": "mediaconvert.amazonaws.com"
			},
			"Action": "sts:AssumeRole"
		}
	]
}
```

### Lambda
to get configurationId:
`aws --profile elliptica s3api get-bucket-notification-configuration --bucket ellipticavideos`
get bucket location:
`aws --profile elliptica s3api get-bucket-location --bucket ellipticavideo`

### Switch Regions
[here's how](https://docs.aws.amazon.com/prescriptive-guidance/latest/patterns/copy-data-from-an-s3-bucket-to-another-account-and-region-by-using-the-aws-cli.html)

#### Cloudfront

Find under the Origin>access control section of the cloudfront distro config
