/* eslint-disable @typescript-eslint/no-unused-vars */

import { Request, Response, NextFunction } from 'express';
import * as bcrypt from 'bcrypt';

import pool from '@core/models/Pool';
import { RowDataPacket } from 'mysql2';

type Empty = Record<string, never>;

type User = {
  email: string;
  username: string;
  password: string;
};

class UserController {
  static async allUsers(req: Request, res: Response, next: NextFunction) {
    const [rows] = await pool.query('SELECT * FROM users');
    console.log(rows);
  }

  static async home(
    req: Request<Empty, Empty, { email: string; username: string; password: string }>,
    res: Response,
    next: NextFunction
  ) {
    //
  }

  static async signup(
    req: Request<Empty, Empty, { email: string; username: string; password: string }>,
    res: Response,
    next: NextFunction
  ) {
    try {
      if (!req.body.email || !req.body.password || !req.body.username) {
        return res.status(400).json({
          status: 'fail',
          message: 'Campos obrigatórios em falta',
        });
      }

      await pool.execute(
        `
        INSERT INTO 
        users (email, username, password)
        VALUES (?,?,?) 
      `,
        [req.body.email, req.body.username, await bcrypt.hash(req.body.password, 10)]
      );

      return res.status(201).json({ status: 'success', message: 'Conta criada com sucesso' });
    } catch (err) {
      if (((err as any).sqlMessage as string).startsWith('Duplicate')) {
        return res.status(409).json({ status: 'fail', message: 'Esse email já está em uso' });
      }
    }
  }

  static async login(
    req: Request<Empty, Empty, { email: string; password: string }>,
    res: Response
  ) {
    try {
      if (!req.body.email || !req.body.password) {
        return res.status(400).json({
          status: 'fail',
          message: 'Campos obrigatórios faltando',
        });
      }

      const [rows] = await pool.execute(
        `
        SELECT password 
        FROM users 
        WHERE email = ?
    `,
        [req.body.email]
      );

      if (
        (rows as RowDataPacket[]).length === 0 ||
        !(await bcrypt.compare(
          req.body.password,
          ((rows as RowDataPacket[])[0] as { password: string }).password
        ))
      ) {
        return res.status(403).json({ status: 'fail', message: 'Email ou Senha incorretos' });
      }

      return res.status(200).json({ status: 'success', message: 'Logado com sucesso' });
    } catch (err) {
      console.log(err);
    }
  }
}

export default UserController;
