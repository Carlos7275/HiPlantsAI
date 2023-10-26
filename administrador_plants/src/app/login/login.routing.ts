import {NgModule} from '@angular/core';
import {Routes,RouterModule} from '@angular/router';
import { LoginComponent } from './login.component';


const routes:Routes=[

{path:'',component:LoginComponent}

]

@NgModule({
  imports:[RouterModule.forChild(Routes)],
  exports:[RouterModule]
})

export class LoginRouteModule{}
