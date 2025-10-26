resource "aws_iam_user" "user1" {
  name = "user_1"
  tags = {
    team = "devops"
  }
}

resource "aws_iam_user" "user2" {
  name = "user_2"
  tags = {
    team = "cloud"
  }
}
resource "aws_iam_user" "user3" {
  name = "aman"
  tags = {
    team = "cloud"
  }
}

resource "aws_iam_group_membership" "multiple_usr_in_grp" {
  name = "tf-testing-group-membership"

  users = [
    aws_iam_user.user1.name,
    aws_iam_user.user2.name
  ]

  group = aws_iam_group.grp1.name
}


