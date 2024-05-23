import express, { Application } from "express";
import addressRoutes from "../routes/addresses";
import cors from "cors";

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

  listen(): void {
    this.app.listen(this.port, () => {
      console.log("Server is running on port:", this.port);
    });
  }
}

export default Server;
