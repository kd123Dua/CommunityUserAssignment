import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from 'lightning/actions';
import createUser from '@salesforce/apex/UserCreationClass.createUser';

export default class CreateCommunityUser extends LightningElement {
    @api recordId;
    @api objectApiName;
    
    showToastMsg(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(event);
    }

    handleClick(event)
    {
        createUser({ recordId :this.recordId})
        .then(result =>
        {
        this.showToastMsg('Success!', 'User Created Successfully', 'Success');
        })
        .catch(error =>
            {
                if(error.body.message === 'Insert failed. First exception on row 0; first error: UNKNOWN_EXCEPTION, portal account owner must have a role: []')
                {
                 this.showToastMsg('Error!', 'Add contact to an Account', 'Error');
                }
                else if(error.body.message==='Insert failed. First exception on row 0; first error: PORTAL_USER_ALREADY_EXISTS_FOR_CONTACT, portal user already exists for contact: []')
                {
                    this.showToastMsg('Error','User already exist for this contact','Error');
                }
                else if(error.body.message === 'Insert failed. First exception on row 0; first error: LICENSE_LIMIT_EXCEEDED, License Limit Exceeded - Customer Community: []')
                {
                 this.showToastMsg('ERROR!', 'Oops!! Your License Limit Exceeded', 'Error');
                }
                else if(error.body.message === 'Insert failed. First exception on row 0; first error: FIELD_INTEGRITY_EXCEPTION, Username must be in the form of an email address (for example, john@acme.com): Username: [Username]')
                {
                this.showToastMsg('ERROR!', 'Please provide Email adrress', 'Error');
                }
                else
                {
                this.showToastMsg('ERROR!', error.body.message, 'Error');
                }
              
        });
    }

    handleSuccess ()
    {
     this.dispatchEvent(new CloseActionScreenEvent());
    }
}

