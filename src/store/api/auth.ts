// src/store/authApi.ts
import { api } from './apiSlice';
import type {
  SignUpRequest,
  SignInRequest,
  AuthResponse,
  ResetPasswordRequest,
  UpdatePasswordRequest,
  ResetPasswordWithTokenRequest,
  SendVerifyMailRequest,
  SetPasswordForUserRequest
} from '@/lib/api/types';

const JAVA_PREFIX = "/java"; // ✅ All Java backend endpoints go through /java

export const authApi = api.injectEndpoints({
  endpoints: (build) => ({
    getProfile: build.query<AuthResponse['data']['userInfo'], void>({
      query: () => ({
        url: `${JAVA_PREFIX}/profile`,
        method: 'GET',
      }),
      providesTags: ['Auth'],
    }),

    signUp: build.mutation<AuthResponse, SignUpRequest>({
      query: (data) => ({
        url: `${JAVA_PREFIX}/signup`,
        method: 'POST',
        body: data,
      }),
      invalidatesTags: ['Auth'],
    }),

    signIn: build.mutation<AuthResponse, SignInRequest>({
      query: (data) => ({
        url: `${JAVA_PREFIX}/unsecure/builderlogin`,
        method: 'POST',
        body: data,
      }),
      invalidatesTags: ['Auth'],
    }),

    signOut: build.mutation<void, void>({
      query: () => ({
        url: `${JAVA_PREFIX}/signout`,
        method: 'POST',
      }),
      invalidatesTags: ['Auth'],
    }),

    resetPasswordWithToken: build.mutation<{ message: string }, ResetPasswordWithTokenRequest>({
      query: (data) => ({
        url: `${JAVA_PREFIX}/unsecure/resetpassword`,
        method: 'POST',
        body: data,
      }),
    }),

    updatePassword: build.mutation<{ message: string }, UpdatePasswordRequest>({
      query: (data) => ({
        url: `${JAVA_PREFIX}/update-password`,
        method: 'PATCH',
        body: data,
      }),
    }),

    verifyEmail: build.mutation<{ message: string }, { token: string }>({
      query: (data) => ({
        url: `${JAVA_PREFIX}/verify-email`,
        method: 'POST',
        body: data,
      }),
    }),

    resendVerification: build.mutation<{ message: string }, { email: string }>({
      query: (data) => ({
        url: `${JAVA_PREFIX}/resend-verification`,
        method: 'POST',
        body: data,
      }),
    }),

    sendVerifyMail: build.mutation<{ message: string }, SendVerifyMailRequest>({
      query: (data) => ({
        url: `${JAVA_PREFIX}/unsecure/verify/mail`,
        method: 'GET',
        params: { email: data.email },
      }),
    }),

    setPasswordForUser: build.mutation<{ message: string }, SetPasswordForUserRequest>({
      query: (data) => ({
        url: `${JAVA_PREFIX}/unsecure/user/setpwd`,
        method: 'POST',
        body: data,
      }),
    }),

    updateProfile: build.mutation<AuthResponse['data']['userInfo'], Partial<AuthResponse['data']['userInfo']>>({
      query: (data) => ({
        url: `${JAVA_PREFIX}/profile`,
        method: 'PATCH',
        body: data,
      }),
      invalidatesTags: ['Auth'],
    }),
  }),
});

export const {
  useGetProfileQuery,
  useSignUpMutation,
  useSignInMutation,
  useSignOutMutation,
  useResetPasswordWithTokenMutation,
  useUpdatePasswordMutation,
  useVerifyEmailMutation,
  useResendVerificationMutation,
  useSendVerifyMailMutation,
  useSetPasswordForUserMutation,
  useUpdateProfileMutation,
} = authApi;
