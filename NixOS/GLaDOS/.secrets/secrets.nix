let
  ginner = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHb8Inhd1S6cza7Q+bakER5CxnSibaUN+lDIkYupBaqG";
  users = [ ginner ];

  GLaDOS = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDbayPaM0ke3Yd7FW0AsZmmdoS5hXyZtF2pul4raeIaZ";
  systems = [ GLaDOS ];
in
{
  "ghcr-token.age".publicKeys = [ ginner GLaDOS ];
  "namecheap-api.age".publicKeys = [ ginner GLaDOS ];
}
