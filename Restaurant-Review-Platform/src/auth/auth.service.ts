import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { User } from 'src/schemas/user.schema';
import * as bcrypt from 'bcrypt';
import { JwtService } from '@nestjs/jwt';
import { SignUpDto } from './dto/signup.auth.dto';
import { validate } from 'class-validator';
import { LoginDto } from './dto/login.auth.dto';
import { LogoutDto } from './dto/logout.auth.dto';
import { HttpException, HttpStatus } from '@nestjs/common';


@Injectable()
export class AuthService {
  constructor(
    @InjectModel(User.name) private userModel: Model<User>,
    private jwtService: JwtService,
  ) {}

  async signUp(
    signUpDto: SignUpDto,
  ): Promise<{ access_token: string; roles: any; username: string; email: string; createdAt: Date }> {
    const { username, email, password, roles } = signUpDto;
  
    if (roles.includes('admin')) {
      const existingAdmin = await this.userModel.findOne({ roles: 'admin' }).exec();
      if (existingAdmin) {
        throw new HttpException('An admin already exists', HttpStatus.CONFLICT);
      }
    }
  
    const hashedPassword = await bcrypt.hash(password, 10);
  
    const user = new this.userModel({
      username,
      email,
      password: hashedPassword,
      roles,
    });
    await user.save();
  
    const payload = {
      sub: user._id,
      username: user.username,
      email: user.email,
      roles: user.roles,
    };
  
    const accessToken = await this.jwtService.signAsync(payload);
    const createdAt = user.get('createdAt').toLocaleDateString();  
    return {
      access_token: accessToken,
      roles: payload.roles,
      username: payload.username, 
      email: email,
      createdAt: createdAt 
    };
  }
  
  
  async login(
    loginDto: LoginDto,
  ): Promise<{ access_token: string; roles: any; owner: any }> {
    const { email, password } = loginDto;

    const user = await this.userModel.findOne({ email });

    if (user.isBanned){
      throw new BadRequestException(`user ${user.username} is banned`);
    }

    if (!user) {
      throw new BadRequestException('Invalid credentials');
    }

    const isMatch = await bcrypt.compare(password, user.password);

    if (!isMatch) {
      throw new BadRequestException('Invalid credentials');
    }

    const payload = {
      sub: user._id,
      username: user.username,
      roles: user.roles,
    };

    return {
      access_token: await this.jwtService.signAsync(payload),
      roles: payload['roles'],
      owner: payload['sub'],
    };
  }

  async logout(): Promise<{access_token: string}> {
    return {
      access_token: ''
    }
  }
}
