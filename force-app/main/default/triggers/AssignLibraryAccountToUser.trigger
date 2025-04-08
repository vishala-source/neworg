trigger AssignLibraryAccountToUser on User (after insert) { 
    Id communityProfileId = '00egK000000tTsbQAE'; // Community User Profile ID
    
    User newUser = Trigger.new[0]; // Directly access the single User record

    if (newUser.ProfileId == communityProfileId) { // Ensure it's a Community User
        try {
            // TEMP FIX: Use a hardcoded Account Name
            String accountName = 'Default Library Account';
            
            Account acc = [
                SELECT Id FROM Account 
                WHERE Name = :accountName 
                LIMIT 1
            ];

            if (acc != null && newUser.ContactId != null) {
                Contact userContact = [
                    SELECT Id, AccountId 
                    FROM Contact 
                    WHERE Id = :newUser.ContactId 
                    LIMIT 1
                ];
                
                if (userContact != null) {
                    userContact.AccountId = acc.Id;
                    update userContact;
                }
            }
        } catch (Exception e) {
            System.debug('Error: ' + e.getMessage());
        }
    }
}