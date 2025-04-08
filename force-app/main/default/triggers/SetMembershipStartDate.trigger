trigger SetMembershipStartDate on Member__c (before insert) {
    for (Member__c newMember : Trigger.new) {
        if (newMember.Membership_Start_Date__c == null) {
            newMember.Membership_Start_Date__c = Date.today();
        }
    }
}