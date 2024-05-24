import express, { Application } from "express";
import addressRoutes from "../routes/addresses";
import cors from "cors";
import db from "../db/connection";
import sequelize from "sequelize/types/sequelize";

class Server {
  private app: Application;
  private port: string;
  private apiPaths = {
    addresses: "/api/addresses",
  };

  constructor() {
    this.app = express();
    this.port = process.env.PORT || "8000";

    // Initialize methods
    this.dbConnection();
    this.middlewares();
    this.routes();
  }

  routes(): void {
    this.app.use(this.apiPaths.addresses, addressRoutes);
  }

  middlewares(): void {
    // CORS
    this.app.use(cors());

    // Read payload
    this.app.use(express.json());

    // Public folder
    this.app.use(express.static("public"));
  }

  async dbConnection() {
    try {
      await db.authenticate();
      await db.sync();
    } catch (error) {
      throw new Error(`${error}`);
    }
  }

  listen(): void {
    this.app.listen(this.port, () => {
      console.log("Server is running on port:", this.port);
    });
  }
}

export default Server;
