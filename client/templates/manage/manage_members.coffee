Template.manageMembers.helpers {
  log : ()-> console.log this

  title : ()-> "Manage Member Page."

  userNow : ()->
    usersResult = Meteor.users.findOne {}
    usersResult.username

  users : ()->
    Meteor.subscribe "userTemp",Meteor.userId()
    Meteor.users.find {}

  isAdmin : (group)-> if group=="administrator" then true else false

  isSelf : (id)-> if id is Meteor.userId() then true else false

}

Template.manageMembers.events {
  "click .toggle-admin" : (e)->
    target = $(e.target)
    targetUserId = target.data "userid"
    targetUserGroup = "member"

    if targetUserId isnt Meteor.userId()
      if userGroupPermission[Meteor.users.findOne(targetUserId).profile.group]("manage", "manage") isnt true
        targetUserGroup = "administrator"
      else
        targetUserGroup = "member"

      Meteor.users.update targetUserId,{$set: {"profile.group" : targetUserGroup} },(error)->
        if error then console.log error.reason

}