/**
 * @description       : 
 * @author            : Concret.io
 * @group             : 
 * @last modified on  : 12-14-2022
 * @last modified by  : Concret.io

trigger SendMailsOnUserCreation on User (after insert) {
    List<Messaging.Email> emailList=new List<Messaging.Email>();
    for(User user1:trigger.new)
    {
        if(user1.Email!=null)
        {    
            System.debug(user1);
            Messaging.SingleEmailMessage emailMsg=new Messaging.SingleEmailMessage();
            String[] toAddress = new String[]{user1.Email};
            emailMsg.setToAddresses(toAddress);
            String emailSub = 'Welcome'+ user1.FirstName;
            emailMsg .setSubject(emailSub);
            String disName='Karan kumar dua';
            emailMsg.setSenderDisplayName(disName);

            String content= 'Hi ' + user1.FirstName + ',<br/><br/>' + 
                             'Welcome you are now a community user';
            emailMsg.setHtmlbody(content);
            emailList.add(emailMsg);                 
        }
    }
    System.debug('Email List'+emailList);
    Messaging.sendEmail(emailList);

}*/