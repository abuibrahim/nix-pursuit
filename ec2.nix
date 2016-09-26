let
  region = "us-west-2";
  accessKeyId = "default";

in {
  pursuit = { resources, ... }: {
    deployment =
      { targetEnv = "ec2";
        ec2 =
          { instanceType = "t2.medium";
            associatePublicIpAddress = true;
            keyPair = resources.ec2KeyPairs.pursuit-keys;
            ebsInitialRootDiskSize = 6;
            blockDeviceMapping."/dev/xvdf" = { disk = "vol-XXXXXXXXXXXXXXXXX"; };
            inherit region accessKeyId;
          };
        route53 =
          { hostName = "pursuit.purescript.org";
            usePublicDNSName = true;
            inherit region accessKeyId;
          };
      };
    fileSystems."/var/lib" =
      { autoFormat = true;
        fsType = "ext4";
        device = "/dev/xvdf";
      };
  };

  resources.ec2KeyPairs.pursuit-keys =
    { inherit region accessKeyId; };
}
