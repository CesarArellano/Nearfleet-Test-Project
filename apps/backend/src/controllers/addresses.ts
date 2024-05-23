import { Request, Response } from "express";

export const getAddresses = (req: Request, res: Response) => {
  res.json({
    msg: "getAddresses",
  });
};

export const createAddress = (req: Request, res: Response) => {
  res.json({
    msg: "createAddress",
  });
};

export const updateAddress = (req: Request, res: Response) => {
  res.json({
    msg: "updateAddress",
  });
};

export const deleteAddress = (req: Request, res: Response) => {
  res.json({
    msg: "deleteAddress",
  });
};
