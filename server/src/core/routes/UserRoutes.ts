import { IRouter, Router } from 'express';

import UserController from '@core/controllers/UserController';

class UserRoutes {
  public router: IRouter;

  constructor() {
    this.router = Router();

    this.router.get('/', UserController.home);
    this.router.post('/api/v1/signup', UserController.signup);
    this.router.post('/api/v1/login', UserController.login);
  }
}

export default UserRoutes;
