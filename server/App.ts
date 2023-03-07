import express from 'express';
import cors from 'cors';
import { config } from 'dotenv';

import UserRoutes from '@core/routes/UserRoutes';

class App {
  private app: express.Application;
  private UserRouter = new UserRoutes().router;

  constructor(port: number) {
    this.app = express();
    this.configurations(port);
    this.routes();
  }

  private configurations(port: number) {
    config({ path: '.env' });
    // console.log(
    //   process.env.MYSQL_HOST,
    //   process.env.MYSQL_USER,
    //   process.env.MYSQL_PASSWORD,
    //   process.env.MYSQL_DATABASE
    // );
    this.app.listen(port);
    this.app.use(cors());
    this.app.use(express.json());
  }

  private routes() {
    this.app.use('/', this.UserRouter);
  }
}

new App(5050);
